# --- Tool Integrations ---
eval "$(keychain --eval --quiet)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# Rebind default fzf triggers.
# Must come after `fzf --zsh` above, which defines fzf-file-widget / fzf-cd-widget.
bindkey -r '^T'
bindkey -r '\ec'
bindkey -r '^R'
bindkey '^[f' fzf-file-widget    # Alt+F for files
bindkey '^[d' fzf-cd-widget      # Alt+D for directories
bindkey '^[r' fzf-history-widget # Alt+R for history

# Bare interactive `fzf` reveals dotfiles on `.` (preview comes from FZF_DEFAULT_OPTS).
# For piped `cmd | fzf` the lines aren't paths, so --preview= turns the preview off.
fzf() {
  if [[ -t 0 ]]; then
    command fzf --bind "$(_fzf_reload f)" "$@"
  else
    command fzf --preview= "$@"
  fi
}

# `**<TAB>` fuzzy completion. fd hides dotfiles by default (like the pickers);
# typing `.`/`/` reveals them. Base = fzf's $dir local (visible because zsh runs
# the last pipeline stage in the current shell). No path arg for cwd → no `./`.
_fzf_compgen_path() { if [[ $1 == . || -z $1 ]]; then fd --type f --follow --exclude .git; else fd --type f --follow --exclude .git . "$1"; fi }
_fzf_compgen_dir()  { if [[ $1 == . || -z $1 ]]; then fd --type d --follow --exclude .git; else fd --type d --follow --exclude .git . "$1"; fi }

# reveal-on-dot bind; $1 = fd type. Bakes $dir as _fzf_reload's path suffix (none for cwd).
_fzf_creload() { local p=; [[ ${dir:-.} != . ]] && p=" . ${(q)dir}"; _fzf_reload "$1" "$p" }

# Per-command preview + a label naming what's being completed. `command fzf` skips the wrapper.
_fzf_comprun() {
  local cmd=$1; shift
  local lbl=$'\uf002'" $cmd " pos='--border-label-pos=3'
  case "$cmd" in
    cd)           command fzf --border-label="$lbl" $pos --preview 'eza --tree --level=2 --color=always {} | head -200' --bind "$(_fzf_creload d)" "$@" ;;
    export|unset) command fzf --border-label="$lbl" $pos --preview 'eval echo \$\{}'                                                            "$@" ;;
    ssh)          command fzf --border-label="$lbl" $pos --preview 'dig +short {}'                                                               "$@" ;;
    *)            command fzf --border-label="$lbl" $pos --preview "$(_fzf_preview {})" --bind "$(_fzf_creload f)"                                "$@" ;;
  esac
}
