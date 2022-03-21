. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases
. ~/.dotfiles/zsh/helpers

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
export AWS_SDK_LOAD_CONFIG=true

# set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# bit of a hack but opt-c doesn't work on Mac otherwise
bindkey "ç" fzf-cd-widget

# set up autocompletions
autoload -U compinit; compinit
