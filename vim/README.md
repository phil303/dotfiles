# Installation:
## Clone in dotvim files:

    git clone git@github.com:phil303/dotvim.git ~/.vim

## Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

## Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

## Install pathogen:

    git clone https://github.com/tpope/vim-pathogen.git

# Upgrading Bundles:
## Upgrading one plugin bundle
    
    cd ~/.vim/bundle/
    git pull origin master

## Upgrading ALL bundled plugins

    (sudo) git submodule foreach git pull origin master

### Recursive update for deeper plugins

    (sudo) git submodule foreach --recursive pull origin master

# Installing and Removing Bundles:
## Installing
    cd ~/.vim/bundle/
    git submodule add <plugin_url> <relative_path>
    git submodule init

## Uninstalling
    Remove from .gitmodules
    Remove from .git/config
    git rm --cached 

[Related VimCast](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)
