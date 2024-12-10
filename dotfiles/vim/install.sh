#!/usr/bin/env bash

# Ensure ~/.vimbundles directory exists and switch to it
mkdir -p ~/.vimbundles
cd ~/.vimbundles || exit 1

# Function to clone or update Vim bundles
get_bundle() {
  local owner="$1"
  local repo="$2"
  local url="https://github.com/${owner}/${repo}.git"

  (
    if [ -d "$repo" ]; then
      echo "Updating ${owner}/${repo}..."
      cd "$repo" || exit 1
      git pull --rebase
    else
      echo "Cloning ${owner}/${repo}..."
      git clone "$url"
    fi
  )
}

# List of bundles to install or update
declare -a bundles=(
  "duff vim-bufonly"
  "elzr vim-json"
  "fatih vim-go"
  "github copilot.vim"
  "godlygeek tabular"
  "hashivim vim-hashicorp-tools"
  "hashivim vim-terraform"
  "jgdavey tslime.vim"
  "jgdavey vim-blockle"
  "jgdavey vim-turbux"
  "junegunn fzf"
  "kchmck vim-coffee-script"
  "mileszs ack.vim"
  "pangloss vim-javascript"
  "rking ag.vim"
  "rust-lang rust.vim"
  "therubymug vim-pyte"
  "tomasr molokai"
  "tpope vim-abolish"
  "tpope vim-bundler"
  "tpope vim-commentary"
  "tpope vim-cucumber"
  "tpope vim-endwise"
  "tpope vim-eunuch"
  "tpope vim-fugitive"
  "tpope vim-git"
  "tpope vim-haml"
  "tpope vim-markdown"
  "tpope vim-pathogen"
  "tpope vim-projectionist"
  "tpope vim-ragtag"
  "tpope vim-rails"
  "tpope vim-rake"
  "tpope vim-repeat"
  "tpope vim-rhubarb"
  "tpope vim-rsi"
  "tpope vim-sensible"
  "tpope vim-sleuth"
  "tpope vim-speeddating"
  "tpope vim-surround"
  "tpope vim-tbone"
  "tpope vim-unimpaired"
  "tpope vim-vividchalk"
  "vim-scripts bufkill.vim"
)

# Process each bundle
for bundle in "${bundles[@]}"; do
  get_bundle $bundle
done

# Generate helptags for Pathogen
vim -c 'call pathogen#helptags()|q'

echo "All bundles updated successfully!"
