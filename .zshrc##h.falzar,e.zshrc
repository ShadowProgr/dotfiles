# ~/.zshrc — thin loader. Real config: ${XDG_CONFIG_HOME:-~/.config}/zsh/*.zsh
# Sourced in numeric order — the dependencies are real:
#   00 env     exports read by everything below
#   10 plugins compinit before fzf-tab; syntax-highlighting last
#   20 keybind needs autopair (^H) + history-substring-search loaded
#   30 aliases independent
#   40 tools   `fzf --zsh` must define widgets before the Alt+F/D rebinds
#   90 local   machine-specific / installer-managed
# (N) glob → empty dir is a no-op; new fragments need no edit here.

for _conf in "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/*.zsh(N); do
  source "$_conf"
done
unset _conf
