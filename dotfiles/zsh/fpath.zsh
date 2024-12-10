# Add each topic folder in $DOTHOME to $fpath for custom functions and completion scripts
for topic_folder ($DOTHOME/*) {
  if [ -d "$topic_folder" ]; then
    fpath=("$topic_folder" $fpath)
  fi
}

# Add standard site-specific paths for Zsh completion and functions
fpath=(
  /opt/homebrew/share/zsh/site-functions  # macOS Homebrew
  /usr/local/share/zsh/site-functions     # Common location for site functions
  $fpath
)
