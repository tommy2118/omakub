# Pipe the public key to the clipboard
pubkey() {
  if [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
    if command -v pbcopy &>/dev/null; then
      # macOS clipboard
      more "$HOME/.ssh/id_rsa.pub" | pbcopy
      echo "=> Public key copied to pasteboard."
    elif command -v xclip &>/dev/null; then
      # Ubuntu clipboard
      xclip -selection clipboard < "$HOME/.ssh/id_rsa.pub"
      echo "=> Public key copied to clipboard."
    elif command -v wl-copy &>/dev/null; then
      # Wayland clipboard
      wl-copy < "$HOME/.ssh/id_rsa.pub"
      echo "=> Public key copied to clipboard (Wayland)."
    else
      echo "Error: No clipboard utility found. Here is your public key:"
      cat "$HOME/.ssh/id_rsa.pub"
    fi
  else
    echo "Error: Public key file not found at $HOME/.ssh/id_rsa.pub."
  fi
}
