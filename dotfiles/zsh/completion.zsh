# Case-insensitive matching for lowercase input
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Prevent completion when pasting text containing tabs
zstyle ':completion:*' insert-tab pending

# Customization for kill-like commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $(whoami) -o pid,user,comm -w -w"

# SSH-specific completion preferences
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

# Ignore certain functions (until explicitly called by the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# Accept exact matches in completions
zstyle ':completion:*' accept-exact '*(N)'

# Enable and configure caching for faster completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache
