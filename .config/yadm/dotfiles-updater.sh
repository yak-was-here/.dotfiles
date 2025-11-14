#!/bin/bash

# Get remote HEAD SHA using ls-remote (fast, no fetch needed)
remote_sha=$(yadm ls-remote origin HEAD 2>/dev/null | cut -f1)
exit_status=$?

# Check if ls-remote failed (connection error, auth error, etc.)
if [ $exit_status -ne 0 ]; then
    echo 'Unable to check for .dotfiles updates (connection failed)';
fi

# Check if bootstrap is needed by comparing remote commit with last bootstrapped commit
last_bootstrap_sha=""
if [ -f "$HOME/.last-yadm-bootstrap" ]; then
    last_bootstrap_sha=$(cat "$HOME/.last-yadm-bootstrap")
fi

if [ "$last_bootstrap_sha" != "$remote_sha" ]; then
    echo '.dotfiles update available';
    echo 'Run "yadm bootstrap" to update your .dotfiles';
else
    echo '.dotfiles up to date';
fi