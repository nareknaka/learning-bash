#!/bin/bash
# Write a script that checks if git, curl, and vim are installed.
# If missing, install them automatically.
# Log the actions into /var/log/package_audit.log.


for pkg in git curl vim; do
    if command -v "$pkg" &>/dev/null; then
        echo "$pkg is installed"
    else
        echo "$pkg is NOT installed"
        sudo apt-get update
        sudo apt-get install -y "$pkg"
    fi
done