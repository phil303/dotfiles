alias l='ls -al'
alias gist='git log'
alias gs='git status'
alias cleanpyc='find . -name "*.pyc" -print0 | xargs -0 -n1 rm'
alias find-process='ps -ef | grep'

# Set up ZSH
export ZSH=$HOME/.dotfiles/zsh/oh-my-zsh
export ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

PROMPT='%{$fg_bold[blue]%}➜ %{$fg_bold[cyan]%}%t %{$fg[yellow]%}${PWD/#$HOME/~} %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%F{154}±|%f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%B✘%b%F{154}|%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%F{154}|"

HISTSIZE=1000
SAVEHIST=1000

# Brew libraries
export PATH=/opt/homebrew/bin:$PATH

# asdf
. $(brew --prefix asdf)/libexec/asdf.sh

# Go
export GOROOT=$(asdf where go)/go
export GOPATH=$HOME/Code/Go
export PATH=$GOPATH/bin:$PATH

export EDITOR=vim

ulimit -n 10000

# point to custom zsh functions
FPATH=$FPATH:$HOME/.dotfiles/zsh/custom

# set up autocompletions
autoload -U compinit; compinit
# set up custom functions
autoload -U ghe
