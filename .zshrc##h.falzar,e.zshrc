# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# --- Fix Navigation Keys in Zsh ---
# Delete
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
fi
# Insert
if [[ -n "${terminfo[kich1]}" ]]; then
  bindkey "${terminfo[kich1]}" overwrite-mode
fi
# Home (moves cursor to beginning of line)
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi
# End (moves cursor to end of line)
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line
fi
# Page Up (search history backward)
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey "${terminfo[kpp]}"   up-line-or-history
fi
# Page Down (search history forward)
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey "${terminfo[knp]}"   down-line-or-history
fi


# Load and initialise completion system
autoload -Uz compinit
compinit

# Mise
eval "$(/usr/bin/mise activate zsh)"

# Starship
eval "$(starship init zsh)"

# SSH keychain
eval $(keychain --eval --quiet)

# opencode
export PATH=/home/shadowprogr/.opencode/bin:$PATH

# Update alias
alias upd-beaver-ce="sudo dnf install https://dbeaver.io/files/dbeaver-ce-latest-stable.aarch64.rpm -y"
