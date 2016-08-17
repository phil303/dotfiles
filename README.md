# Phil Aquilina Dot Files

## Installation

    git clone git://github.com/phil303/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    # install dotfiles to home directory
    python install.py
    mkdir vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    chsh -s /bin/zsh

## Install Vim Plugins
  
    # in Vim
    :PluginInstall

    # CLI
    vim +PluginInstall +qall

## Install (or Update) Submodules

    gitup
