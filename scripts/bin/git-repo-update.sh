#!/usr/bin/env bash 
 
# Dictionary of git repositories with key as repo path and value as log file path
declare -A REPOS=(
    ["path/repo"]="path-access.log"
)

for repo in "${!REPOS[@]}"; do
    log="${REPOS[$repo]}"

    if [ -d "$repo/.git" ]; then
        cd "$repo" || continue

        git pull --rebase > /dev/null 2>&1
        if [ -n "$log" ]; then
            goaccess "$log" -o ./analytics.html --log-format=CADDY
        fi
    fi
done
