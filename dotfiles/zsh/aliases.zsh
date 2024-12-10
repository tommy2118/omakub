# Reload Zsh configuration
alias reload!='source ~/.zshrc'

# Prevent spelling correction on common commands
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias spec='nocorrect spec'
alias rspec='nocorrect rspec'

# Directory and file listing aliases
alias ll="ls -l"             # Long format listing
alias la="ls -a"             # Show all files including hidden ones
alias l.='ls -ld .[^.]*'     # List only hidden files in the current directory
alias lsd='ls -ld *(-/DN)'   # List only directories

# Directory management
alias md='mkdir -p'          # Create parent directories as needed
alias rd='rmdir'             # Remove empty directories
alias cd..='cd ..'           # Typo-friendly alias for navigating up one level
alias ..='cd ..'             # Shortcut for navigating up one level

# Testing and development
alias spec='spec -c'         # Run spec with colorized output
alias heroku='noglob heroku' # Prevent globbing for heroku CLI
alias be='bundle exec'       # Run commands in the context of the current bundle
