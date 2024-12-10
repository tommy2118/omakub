# Default applications

# Set the default pager
if [[ -z "${PAGER}" ]]; then
  export PAGER='less'
fi

# Set the default editor
if [[ -z "${EDITOR}" ]]; then
  export EDITOR='vim'
fi

# Set the default editor for PostgreSQL with SQL syntax highlighting
export PSQL_EDITOR='vim -c"set syntax=sql"'
