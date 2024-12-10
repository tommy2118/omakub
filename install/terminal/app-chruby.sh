#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Ensure necessary build tools are installed
echo "Installing build tools..."
sudo apt update
sudo apt install -y build-essential pkg-config autoconf automake

# Install chruby
CHRuby_VERSION="0.3.9"
CHRuby_URL="https://github.com/postmodern/chruby/releases/download/v${CHRuby_VERSION}/chruby-${CHRuby_VERSION}.tar.gz"

echo "Installing chruby version ${CHRuby_VERSION}..."

# Download chruby source
wget -q ${CHRuby_URL} -O chruby-${CHRuby_VERSION}.tar.gz

# Extract the tarball
tar -xzf chruby-${CHRuby_VERSION}.tar.gz

# Navigate into the source directory
cd chruby-${CHRuby_VERSION}/

# Install chruby
sudo make install

# Cleanup
cd ..
rm -rf chruby-${CHRuby_VERSION} chruby-${CHRuby_VERSION}.tar.gz

echo "chruby ${CHRuby_VERSION} installed successfully!"

# Add chruby to your shell configuration
if ! grep -q "chruby.sh" ~/.zshrc; then
  echo "Adding chruby initialization to ~/.zshrc..."
  echo 'source /usr/local/share/chruby/chruby.sh' >> ~/.zshrc
  echo 'source /usr/local/share/chruby/auto.sh' >> ~/.zshrc
  echo "Run 'source ~/.zshrc' to load chruby in your current session."
else
  echo "chruby initialization already present in ~/.zshrc."
fi
