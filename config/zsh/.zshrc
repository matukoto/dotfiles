[[ -o interactive ]] || return
[[ -z ${_DOTFILES_ZSH_LOADED-} ]] || return
typeset -g _DOTFILES_ZSH_LOADED=1
typeset -g DOTFILES_ZSH_DIR=${${(%):-%x}:A:h}
[[ -r $DOTFILES_ZSH_DIR/local.zsh ]] && source "$DOTFILES_ZSH_DIR/local.zsh"
typeset -g DOTFILES_ZSH_DATA_DIR=${DOTFILES_ZSH_DATA_DIR:-$XDG_STATE_HOME/zsh}
if (umask 077; command mkdir -p -- "$DOTFILES_ZSH_DATA_DIR") 2>/dev/null; then
  HISTFILE=$DOTFILES_ZSH_DATA_DIR/history
else
  unset HISTFILE
fi
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history inc_append_history hist_ignore_dups hist_ignore_space
setopt interactive_comments no_beep
unsetopt share_history prompt_subst prompt_bang
autoload -Uz compinit
# -i ignores insecure completion directories instead of trusting them.
if [[ -d $DOTFILES_ZSH_DATA_DIR && -w $DOTFILES_ZSH_DATA_DIR ]]; then
  compinit -i -d "$DOTFILES_ZSH_DATA_DIR/zcompdump-$ZSH_VERSION"
else
  compinit -i -D
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ''
if [[ -n ${NVIM-} ]]; then
  bindkey -e
else
  bindkey -v
fi
KEYTIMEOUT=10
bindkey '^R' history-incremental-search-backward
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey -M vicmd '^R' history-incremental-search-backward
[[ -t 0 ]] && export GPG_TTY=$TTY
source "$DOTFILES_ZSH_DIR/functions.zsh"
source "$DOTFILES_ZSH_DIR/prompt.zsh"
source "$DOTFILES_ZSH_DIR/aliases.zsh"
