#!/bin/bash

MODE=$1
FOOT_MODE="/home/shadowprogr/.config/foot/current-mode.ini"

if [ "$MODE" = "dark" ]; then
    /home/shadowprogr/.local/bin/pywalfox update
    echo "initial-color-theme=dark" > "$FOOT_MODE"
    pkill -USR1 foot
else
    /home/shadowprogr/.local/bin/pywalfox update
    echo "initial-color-theme=light" > "$FOOT_MODE"
    pkill -USR2 foot
fi
