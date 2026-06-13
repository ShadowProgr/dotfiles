# --- Keybindings ---

# Navigation keys — guarded by terminfo so they no-op on terminals that lack them.
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char       # Delete
[[ -n "${terminfo[kich1]}" ]] && bindkey "${terminfo[kich1]}" overwrite-mode    # Insert
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line # Home
[[ -n "${terminfo[kend]}"  ]] && bindkey "${terminfo[kend]}"  end-of-line       # End
[[ -n "${terminfo[kpp]}"   ]] && bindkey "${terminfo[kpp]}"   up-line-or-history    # PgUp
[[ -n "${terminfo[knp]}"   ]] && bindkey "${terminfo[knp]}"   down-line-or-history  # PgDn

# Restore Ctrl+Backspace after zsh-autopair overrides it
bindkey '^H' backward-kill-word

# Bind Up/Down arrows to history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
