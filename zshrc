. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases
. ~/.dotfiles/zsh/helpers

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
export AWS_SDK_LOAD_CONFIG=true

# point to custom zsh functions
FPATH=$FPATH:$HOME/.dotfiles/zsh/custom

# set up autocompletions
autoload -U compinit; compinit
# set up custom functions
autoload -U ghe
