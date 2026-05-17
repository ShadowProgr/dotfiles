# --- Environment Variables ---
export PATH=/home/shadowprogr/.opencode/bin:$PATH
export ANTHROPIC_CUSTOM_MODEL_OPTION="claude-opus-4-6"
export ANTHROPIC_CUSTOM_MODEL_OPTION_NAME="Opus 4.6"
export ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION="Previous Opus generation"

# Split wrods by "/"
export WORDCHARS=${WORDCHARS//\/}

# --- Aliases ---
alias upd-beaver-ce="sudo dnf install https://dbeaver.io/files/dbeaver-ce-latest-stable.aarch64.rpm -y"

# --- Base Configuration ---
# Load and initialise completion system
autoload -Uz compinit
compinit

# --- Plugin Manager (Zap) ---
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# plug "zap-zsh/fzf" # Disabled: Using native eval below
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/sudo"
plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-syntax-highlighting"

# --- Keybindings ---

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

# Restore Ctrl+Backspace after zsh-autopair overrides it
bindkey '^H' backward-kill-word

# --- Tool Integrations ---
eval "$(keychain --eval --quiet)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
