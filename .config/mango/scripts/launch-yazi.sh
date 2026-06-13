#!/bin/sh
# Launch yazi from the WM hotkey with the shared fzf/zoxide env.
# mango spawns hotkey children directly and does NOT inherit environment.d or the
# shell rc, so we source the env here before exec'ing the terminal.
. "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf-env.sh"
fzf_yazi_setup
exec foot --app-id=Yazi yazi "$@"
