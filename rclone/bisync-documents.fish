#!/usr/bin/env fish

rclone bisync \
    "$HOME/Documents" \
    "onedrive:Documents" \
    --config "$HOME/.config/rclone/rclone.conf" \
    --create-empty-src-dirs \
    --resilient \
    --recover
# --resync  # Use once to initialize/rebuild the bisync baseline
