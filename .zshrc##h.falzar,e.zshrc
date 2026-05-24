# --- Environment Variables ---
export PATH=/home/shadowprogr/.opencode/bin:$PATH
export ANTHROPIC_CUSTOM_MODEL_OPTION="claude-opus-4-6"
export ANTHROPIC_CUSTOM_MODEL_OPTION_NAME="Opus 4.6"
export ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION="Previous Opus generation"

# Ignore dups with zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Split words by "/" for easier Ctrl+Backspace
export WORDCHARS=${WORDCHARS//\/}

# fzf integration with bat for syntax-highlighted previews
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# bat follows terminal's theme
export BAT_THEME="ansi"

# --- Base Configuration ---
# Load and initialise completion system
autoload -Uz compinit
compinit

# --- Plugin Manager (Zap) ---
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/sudo"
plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
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

# Bind Up/Down arrows to history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- Aliases ---
alias ls="eza --group-directories-first --icons=auto"
alias ll="eza --group-directories-first --icons=auto -lh --git"
alias tree="eza --group-directories-first --icons=auto -lh --git --tree --level=2"
alias upd-beaver-ce="sudo dnf install https://dbeaver.io/files/dbeaver-ce-latest-stable.aarch64.rpm -y"

# --- Tool Integrations ---
eval "$(keychain --eval --quiet)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# Rebind default fzf triggers
bindkey -r '^T'
bindkey -r '\ec'
bindkey '^F' fzf-file-widget  # Ctrl+F for files
bindkey '^[f' fzf-cd-widget   # Alt+F for directories

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/shadowprogr/Projects/omnistream/google-cloud-sdk/path.zsh.inc' ]; then . '/home/shadowprogr/Projects/omnistream/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/shadowprogr/Projects/omnistream/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/shadowprogr/Projects/omnistream/google-cloud-sdk/completion.zsh.inc'; fi


# Added by Antigravity CLI installer
export PATH="/home/shadowprogr/.local/bin:$PATH"
