# --- Aliases ---
_eza='eza --group-directories-first --icons=auto'   # captured at definition time; unset below
alias ls="$_eza"
alias ll="$_eza -lh --git"
alias tree="$_eza -lh --git --tree --level=2"
unset _eza

alias upd-beaver-ce="sudo dnf install https://dbeaver.io/files/dbeaver-ce-latest-stable.aarch64.rpm -y"
