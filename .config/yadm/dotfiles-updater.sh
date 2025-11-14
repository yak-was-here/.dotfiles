#!/bin/bash

# Capture output and exit status
output=$(yadm pull 2>&1)
exit_status=$?

# Check if pull failed (connection error, auth error, etc.)
if [ $exit_status -ne 0 ]; then
    echo 'Unable to check for .dotfiles updates (connection failed)';
    return 0;
fi

# Check if updates were pulled
if echo "$output" | grep -q 'Already up to date.'; then
    echo '.dotfiles up to date';
else
    echo '.dotfiles update available';
    echo 'Run "yadm bootstrap" to update your .dotfiles';
fi