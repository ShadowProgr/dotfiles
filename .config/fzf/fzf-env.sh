# Shared fzf / zoxide / bat environment — single source of truth.
#
# Sourced by zsh/00-env.zsh, the mango yazi launcher, and the file-chooser portal
# wrapper, so fzf/zoxide look identical however yazi starts. GUI launchers never
# read .zshrc, which is why this lives on its own.
#
# POSIX sh only — must source cleanly under sh, bash and zsh.

# Build helpers — they only PRINT strings, so they're shell-agnostic. zsh reuses
# them for its pickers and `**` completion (zsh/00-env.zsh, zsh/40-tools.zsh).
# _fzf_reload's $2 is an optional fd path suffix (zsh bakes $dir in via it).
_fzf_reload() { printf '%s' "change:transform:case \$FZF_QUERY in .*|*/.*) echo \"reload(fd --type $1 --hidden --follow --exclude .git$2)\" ;; *) echo \"reload(fd --type $1 --follow --exclude .git$2)\" ;; esac"; }
_fzf_preview() { printf '%s' "if [ -d $1 ]; then eza --tree --level=2 --color=always $1 | head -200; elif [ -f $1 ]; then bat -n --color=always --line-range=:500 $1; else echo $1; fi 2>/dev/null"; }

# File/dir lists (fd hides dotfiles by default → so do yazi's `z` and the pickers).
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --follow --exclude .git'

# Global look + preview. This --preview is what bare fzf and tools that exec the
# fzf binary inherit — notably yazi's `z` key. Picker/history opts (00-env.zsh)
# override it where they need something different.
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border=rounded
  --border-label='  fzf ' --border-label-pos=3
  --info=inline
  --prompt='› '
  --pointer='▶'
  --marker='✓'
  --cycle
  --preview '$(_fzf_preview {})'
  --preview-window='right:60%:wrap'
  --bind='ctrl-/:change-preview-window(down|hidden|)'
"

# zoxide interactive (yazi's `Z` key, and `zi`). zoxide spawns the fzf binary
# itself and reads only this. Lines are `score⎵path`, so match/preview use {2..}.
export _ZO_FZF_OPTS="
  --no-sort --nth=2.. --tabstop=1 --exit-0 --select-1
  --height=40% --layout=reverse --border=rounded --info=inline --cycle
  --bind 'ctrl-z:ignore,btab:up,tab:down'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --preview 'eza --tree --level=2 --color=always {2..} | head -200'
  --preview-window='right:60%:wrap'
"

# bat follows the terminal theme (used by the previews above).
export BAT_THEME='ansi'

# Call from yazi launchers only (never the shell). Two jobs:
#  - margin/padding → fzf floats as a centered modal (yazi hides its UI anyway).
#  - dotfile-reveal on `.` for the `z` (fzf) picker, via FZF_DEFAULT_OPTS — kept
#    out of the shell, where it'd hijack history/piped/** fzf.
# `change:ignore` shields `Z` (zoxide), which also inherits FZF_DEFAULT_OPTS;
# YAZI_ZOXIDE_OPTS is appended last by the plugin, so it wins.
fzf_yazi_setup() {
  _geo='--height=100% --margin=6%,12% --padding=1 --border=rounded --border-label-pos=3'
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $_geo --border-label='  fzf · file/dir ' --bind '$(_fzf_reload f)'"
  export YAZI_ZOXIDE_OPTS="$_geo --border-label='  zoxide · recent dirs ' --bind change:ignore${YAZI_ZOXIDE_OPTS:+ $YAZI_ZOXIDE_OPTS}"
  unset _geo
}
