#!/bin/bash

MODE=$1

if [ "$MODE" = "dark" ]; then
    /home/shadowprogr/.local/bin/pywalfox update
    # Execute dark mode specific commands
else
    /home/shadowprogr/.local/bin/pywalfox update
    # Execute light mode specific commands
fi
