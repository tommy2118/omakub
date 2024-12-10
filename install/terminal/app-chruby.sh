#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

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
