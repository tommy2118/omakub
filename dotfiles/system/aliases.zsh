# Aliases and Functions
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]]; then
    source "$HOME/.hitch_export_authors"
  fi
}
alias unhitch='hitch -u'

# Kill webkit_server and cucumber processes
alias cukill='pkill -9 -if webkit_server; pkill -9 -if cucumber'

# Common aliases
alias h='history'
alias l='ls -lah'
alias ls='ls -FG'  # macOS-specific style; may work differently on Linux
alias l0="ls -lh | awk '\$5 == 0'"
alias ll='ls -lh'
alias lla='ls -alh'
alias lld='ls -lh | grep ^d'
alias vi='vim'
alias grep='grep --color=auto'
alias pgrep='pgrep -Lif'

# Tar shortcuts
tu() { tar cvzfp "${1%/}.tgz" "$1"; }
ut() { tar xvzfp "$1"; }

######################
# macOS-Specific Aliases
######################
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias show_hidden='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
  alias hide_hidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
fi
