# Update PATH dynamically without duplicating directories
for dir in /usr/local/bin "$DOTHOME/bin" .git/safe/../../bin .git/bin; do
  case ":$PATH:" in
    *:"$dir":*) ;;  # Skip if $dir is already in $PATH
    *)
      if [[ "$dir" == /* ]]; then  # Only add absolute paths if the directory exists
        [ -d "$dir" ] && PATH="$dir:$PATH"
      else
        PATH="$dir:$PATH"  # Add relative paths
      fi
      ;;
  esac
done

# Add additional system directories dynamically
for dir in /usr/local/sbin /opt/local/sbin /usr/X11/bin; do
  case ":$PATH:" in
    *:"$dir":*) ;;  # Skip if $dir is already in $PATH
    *)
      [ -d "$dir" ] && PATH="$PATH:$dir"
      ;;
  esac
done

# Export the updated PATH
export PATH
