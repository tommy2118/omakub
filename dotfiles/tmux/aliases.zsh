# ~/aliases.zsh
# vim:set ft=sh sw=2 sts=2:

# Define directories for tmux sessions
muxable_paths=("${SOURCE_DIR}/trm" "${SOURCE_DIR}/itts" "${SOURCE_DIR}/ke")

# Function to manage tmux sessions
mux() {
  local name cols mux_file

  # Change directory if an argument is provided
  if [ -n "$1" ]; then
    cd "$1" || { echo "Error: Directory '$1' does not exist."; return 1; }
  fi

  # Derive session name from current directory
  name="$(basename "${PWD}" | sed -e 's/\./-/g')"

  # Determine .mux file location (local or home)
  mux_file="${PWD}/.mux"
  [ -f "${mux_file}" ] || mux_file="${HOME}/.mux"

  # Check if tmux session exists, create if not
  if ! tmux has-session -t "${name}" 2>/dev/null; then
    cols="$(tput cols || echo 150)"  # Fallback to 150 if tput fails
    echo "Creating tmux session for '${name}'..."

    # Command for creating a tmux session
    tmux new-session -d -n code -s "${name}" -x"${cols}" -y50 \
      "$(command -v reattach-to-user-namespace >/dev/null && echo 'reattach-to-user-namespace -l zsh' || echo 'zsh')"

    # Source the .mux file if it exists
    if [ -f "${mux_file}" ]; then
      echo "Sourcing ${mux_file} for session '${name}'..."
      name="${name}" source "${mux_file}"
    fi
  fi

  # Attach to the tmux session
  tmux attach-session -t "${name}"
}

# Completion for mux function
compctl -/ -S '' -W "(${SOURCE_DIR} ${muxable_paths[*]})" mux
