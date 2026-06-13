# --- Environment Variables ---

# Keep PATH entries unique (newest wins) — avoids dupes from nested shells.
typeset -U path PATH

# opencode
export PATH="/home/shadowprogr/.opencode/bin:$PATH"

# Enable older Opus
export ANTHROPIC_CUSTOM_MODEL_OPTION="claude-opus-4-7"
export ANTHROPIC_CUSTOM_MODEL_OPTION_NAME="Opus 4.7"
export ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION="Previous Opus generation"

# Ignore dups with zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Split words by "/" for easier Ctrl+Backspace
export WORDCHARS=${WORDCHARS//\/}

# Shared fzf/zoxide/bat env + _fzf_reload/_fzf_preview helpers (see fzf-env.sh for why).
# The interactive-only picker opts below stay here — yazi doesn't use them.
source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf-env.sh"

# Alt+F files: bat preview, capped at 500 lines so huge files don't stall.
export FZF_CTRL_T_OPTS="
  --border-label='  files ' --border-label-pos=3
  --preview 'bat -n --color=always --line-range=:500 {}'
  --bind '$(_fzf_reload f)'
"

# Alt+D dirs: eza tree preview (matches the `tree` alias).
export FZF_ALT_C_OPTS="
  --border-label='  dirs ' --border-label-pos=3
  --preview 'eza --tree --level=2 --color=always {} | head -200'
  --bind '$(_fzf_reload d)'
"

# Alt+R history: preview the full command, ctrl-y to copy it.
export FZF_CTRL_R_OPTS="
  --border-label='  history ' --border-label-pos=3
  --preview 'echo {}' --preview-window down:3:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --header 'ctrl-y: copy · ctrl-/: preview'
"
