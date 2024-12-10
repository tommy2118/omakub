# ~/aliases.zsh
# vim:set ft=sh sw=2 sts=2:

# Ensure `hub` is used if installed; otherwise, fallback to `git`
git() {
  [ -f "$HOME/.hitch_export_authors" ] && . "$HOME/.hitch_export_authors"
  if command -v hub >/dev/null; then
    command hub "$@"
  else
    command git "$@"
  fi
}

# Show Git commit authorship totals
contributions () {
  prog='BEGIN { FS=",? and |, "; OFS="" }
  END { for(name in count) print count[name],"|",name; print NR,"|TOTAL" }
  { for(i=1; i<=NF; i++) { count[$i]++; } }'

  git log --format="%an" "$@" | awk "$prog" | sort -nr | column -t -s '|'
}

# Detect the current Git state (rebase, merge, bisect)
git_current_state () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  local current_state

  if [ -d "$g/rebase-apply" ]; then
    [ -f "$g/rebase-apply/rebasing" ] && current_state="|REBASE"
  elif [ -f "$g/rebase-merge/interactive" ]; then
    current_state="|REBASE-i"
  elif [ -f "$g/MERGE_HEAD" ]; then
    current_state="|MERGING"
  elif [ -f "$g/BISECT_LOG" ]; then
    current_state="|BISECTING"
  fi

  printf "%s" "$current_state"
}

# Get the current local branch
git_local_branch () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  local branch_name

  if [ -d "$g/rebase-apply" ]; then
    branch_name="$(cat "$g/rebase-apply/head-name")"
  elif [ -f "$g/rebase-merge/interactive" ]; then
    branch_name="$(cat "$g/rebase-merge/head-name")"
  elif [ -f "$g/MERGE_HEAD" ]; then
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)"
  else
    if ! branch_name="$(git symbolic-ref HEAD 2>/dev/null)"; then
      if ! branch_name="$(git describe --exact-match HEAD 2>/dev/null)"; then
        branch_name="$(cut -c1-7 "$g/HEAD")..."
      fi
    fi
  fi

  printf "%s" "${branch_name##refs/heads/}"
}

# Display Git prompt info
git_prompt_info () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r b d s
    b=$(git_local_branch)
    r=$(git_current_state)

    local newfile="?? "
    if [ -n "$ZSH_VERSION" ]; then
      newfile='\?\? '
    fi
    d=''
    s=$(git status --porcelain 2>/dev/null)
    [[ $s =~ "$newfile" ]] && d+='+'
    [[ $s =~ "M " ]] && d+='*'
    [[ $s =~ "D " ]] && d+='-'

    printf "${1-"(%s) "}" "${b}${r}${d}"
  fi
}

# Merge current branch into the default branch
merge() {
  local git_interactive=''
  local prompt_before_pushing='true'
  local branch=$(git_local_branch)
  local uncommitted_changes
  uncommitted_changes=$(git status --porcelain 2>/dev/null)
  local default_branch_name
  default_branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

  if [ -n "$1" ]; then
    case $1 in
      -i | --interactive)
        git_interactive="--interactive"
        ;;
      -f | --force)
        prompt_before_pushing="do_not_prompt"
        ;;
      -h | --help)
        echo "Usage: merge [options]"
        echo "Merges your current branch onto ${default_branch_name}."
        echo "Options:"
        echo "  -i, --interactive    Rebase interactively."
        echo "  -f, --no-prompts     Skip prompts before pushing."
        echo
        return
        ;;
    esac
  fi

  if [[ -n ${uncommitted_changes} ]]; then
    echo "You have uncommitted changes. Commit or stash them before proceeding."
    return
  fi

  if [ "$branch" = "$default_branch_name" ]; then
    echo "You cannot merge ${default_branch_name} onto itself."
    return
  fi

  git checkout "$default_branch_name"
  git pull --rebase --prune
  git checkout "$branch"
  git rebase -S $git_interactive "$default_branch_name"
  git push --force-with-lease origin "$branch"
  git checkout "$default_branch_name"
  git merge "$branch"

  if [ "$prompt_before_pushing" != "do_not_prompt" ]; then
    read -p "Push ${default_branch_name} to origin? (No/yes): " push_to_origin
    if [[ ! "$push_to_origin" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo "Did not push ${default_branch_name} to origin."
      return
    fi
  fi

  git push origin "$default_branch_name"
  git push origin --delete "$branch" 2>/dev/null || true
  git branch -D "$branch"
}

# Get the number of available CPU cores
NCPU=$([[ $(uname) = "Darwin" ]] && sysctl -n hw.ncpu || nproc --all)

# Git aliases
alias gap="git add -p"
alias gc="git commit -S -v"
alias gca="git commit -S -v --amend -CHEAD"
alias gd="git diff --no-ext-diff"
alias gdc="gds"
alias gds="git diff --staged --no-ext-diff"
alias gnap="git add -N . && git add -p"
alias gpr="git pull --rebase --prune --jobs=${NCPU}"
alias gst="git status"
