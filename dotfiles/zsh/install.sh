#!/bin/bash
# Switch the default shell to zsh

set -e  # Exit on any error

# Ensure zsh is installed
echo "Checking if zsh is installed..."
if ! command -v zsh &>/dev/null; then
  echo "zsh not found. Installing zsh..."
  sudo apt update
  sudo apt install -y zsh
else
  echo "zsh is already installed."
fi

# Add zsh to /etc/shells if not present
if ! grep -q "$(which zsh)" /etc/shells; then
  echo "Adding zsh to /etc/shells..."
  echo "$(which zsh)" | sudo tee -a /etc/shells
fi

# Change the default shell to zsh
echo "Switching the default shell to zsh..."
chsh -s "$(which zsh)"

# Confirm the change
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo "Default shell changed to zsh. Please restart your session to apply changes."
else
  echo "zsh is now your default shell."
fi

echo "Done! Enjoy using zsh."
