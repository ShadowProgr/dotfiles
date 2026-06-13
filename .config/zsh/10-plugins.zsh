# --- Completion + Plugin Manager (Zap) ---

# Completion system — must load before fzf-tab (below), which hooks into it.
# Recompile the dump at most once a day; skip the security scan otherwise.
autoload -Uz compinit
_zcd="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
[[ -d ${_zcd:h} ]] || mkdir -p ${_zcd:h}
if [[ -n ${_zcd}(#qN.mh+24) ]]; then
  compinit -d "$_zcd"
else
  compinit -C -d "$_zcd"
fi
unset _zcd

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/sudo"
plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-syntax-highlighting"   # keep last: it wraps all existing widgets

# --- fzf-tab: previews + behaviour while TAB-completing ---
# These are completion zstyles, NOT FZF_* env vars — fzf-tab is configured on its own.

zstyle ':completion:*' menu no                        # hand the menu over to fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'     # group headers (fzf-tab needs this)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colorize entries (needs $LS_COLORS)

# Preview candidate: dir→eza tree, file→bat. Single quotes required ($realpath is late-bound by fzf-tab).
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'if [[ -d $realpath ]]; then eza --tree --level=2 --color=always $realpath | head -200;
   elif [[ -f $realpath ]]; then bat -n --color=always --line-range=:500 $realpath;
   else echo $realpath; fi 2>/dev/null'

# Match the look of your other pickers (fzf-tab won't read FZF_DEFAULT_OPTS):
zstyle ':fzf-tab:*' fzf-flags '--preview-window=right:60%:wrap' '--bind=ctrl-/:change-preview-window(down|hidden|)'
