# Add custom functions directory to the $fpath
fpath=($DOTHOME/functions $fpath)

# Autoload custom functions
autoload -U $DOTHOME/functions/*(:t)

# Source additional shell configuration
source "$DOTHOME/system/shellrc.symlink"

# Enable colorized terminal output
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# Load Zsh color definitions
autoload -U colors && colors

# Custom prompt
PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[cyan]%}%~%{$reset_color%}$(git_prompt_info "(%s)")%# '

# Display non-success exit code in the right prompt
RPROMPT="%(?..{%{$fg[red]%}%?%{$reset_color%}})"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt NO_BG_NICE        # Don't lower priority of background tasks
setopt NO_HUP            # Don't send HUP signal to background jobs on exit
setopt NO_LIST_BEEP      # Disable beeping on ambiguous completions
setopt LOCAL_OPTIONS     # Allow local options in functions
setopt LOCAL_TRAPS       # Allow local traps in functions
setopt HIST_VERIFY       # Verify history command before running
setopt SHARE_HISTORY     # Share history between sessions
setopt EXTENDED_HISTORY  # Include timestamps in history
setopt PROMPT_SUBST      # Enable prompt substitutions
setopt CORRECT           # Enable typo correction
setopt COMPLETE_IN_WORD  # Allow completions in the middle of words
setopt APPEND_HISTORY    # Append to history file, don't overwrite
setopt INC_APPEND_HISTORY SHARE_HISTORY  # Incrementally share history
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicate commands in history
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blanks from history

# Keybindings
bindkey -e                          # Use Emacs keybindings
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# External editor support
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Partial word history completion
bindkey '\ep' up-line-or-search
bindkey '\en' down-line-or-search
bindkey '\ew' kill-region

# HashiCorp targets
export VAULT_ADDR="https://vault.ke-eng.io"
export NOMAD_ADDR="https://nomad-servers.ke-eng.io"
