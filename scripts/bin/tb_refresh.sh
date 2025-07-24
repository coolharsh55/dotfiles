#!/usr/bin/env bash

# Locate Thunderbird's global SQLite database (global-messages-db.sqlite) for the active profile
# Default: print resolved path
# --delete / -D : delete the file

echo "Detected OS: $OSTYPE"

case "$OSTYPE" in
  linux*)
    profile_ini="$HOME/.thunderbird/profiles.ini"
    thunderbird_dir="$HOME/.thunderbird"
    ;;
  darwin*)
    profile_ini="$HOME/Library/Thunderbird/profiles.ini"
    thunderbird_dir="$HOME/Library/Thunderbird"
    ;;
  cygwin* | msys* | win32)
    profile_ini="$APPDATA/Thunderbird/profiles.ini"
    thunderbird_dir="$APPDATA/Thunderbird"
    ;;
  *)
    echo "Unsupported OS: $OSTYPE"
    exit 1
    ;;
esac

echo "profiles.ini path: $profile_ini"
echo "Thunderbird base directory: $thunderbird_dir"

if [ ! -f "$profile_ini" ]; then
  echo "profiles.ini not found."
  exit 1
fi

# Step 1: Try to extract per-installation default profile path
install_default=$(awk '
  /^\[Install/ { in_install=1 }
  in_install && /^Default=/ { print $1; exit }
' "$profile_ini" | cut -d= -f2)

# Step 2: If not found, fallback to global Default=1
if [ -z "$install_default" ]; then
  echo "No per-installation default found, falling back to global default."
  install_default=$(awk -F= '
    /^\[Profile/ { section=$0 }
    /^Path=/ { path=$2 }
    /^Default=1/ { print path; exit }
  ' "$profile_ini")
else
  echo "Per-installation default profile: $install_default"
fi

if [ -z "$install_default" ]; then
  echo "No default profile found."
  exit 1
fi

profile_dir="$thunderbird_dir/$install_default"

echo "Resolved profile directory: $profile_dir"

db_file="$profile_dir/global-messages-db.sqlite"
echo "Target DB file path: $db_file"

if [ ! -f "$db_file" ]; then
  echo "global-messages-db.sqlite not found in active profile."
  exit 0
fi

if [[ "$1" == "--delete" || "$1" == "-D" ]]; then
  rm -f "$db_file"
  echo "Deleted $db_file"
else
  echo "Use --delete or -D to delete the file."
fi
