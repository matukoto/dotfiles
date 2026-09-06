# Portable aliases from the Fish abbreviations. No personal or tool-manager paths.
alias s='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpu='git push --set-upstream origin HEAD'
alias gpl='git pull'
alias gl='git log'
alias gs='git switch'
alias gd='git diff'
alias gsc='git switch -c'
alias gcp='git cherry-pick'
alias f='ghf'
alias conf='cd -- "$XDG_CONFIG_HOME"'

if (( $+commands[eza] )); then
  alias ls='eza'
  alias ll='eza -alF --time-style "+%Y/%m/%d %H:%M"'
  alias la='eza -A'
else
  alias ll='ls -alF'
  alias la='ls -A'
fi
alias l='clear && ls'

if (( $+commands[nvim] )); then
  alias v='nvim'
  alias 'v.'='nvim .'
  alias vr='nvim ./README.md'
else
  alias v='vi'
  alias 'v.'='vi .'
  alias vr='vi ./README.md'
fi

# Enable optional tool shortcuts only when the tool is already available.
(( $+commands[gh] )) && alias gas='gh auth switch'
(( $+commands[dotnet] )) && alias fsi='dotnet fsi'
if (( $+commands[deno] )); then
  alias browser-html='deno run -A --unstable npm:browser-sync start --server --files "*.html"'
fi
if (( $+commands[vim-startuptime] && $+commands[nvim] )); then
  alias startuptime='vim-startuptime -count 100 -vimpath nvim'
fi
