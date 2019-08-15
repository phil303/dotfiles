## Installation

    git clone git@github.com:phil303/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    # install dotfiles to home directory
    python install.py
    mkdir vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## Vim Plugins
  
    # in Vim
    :PluginInstall

    # CLI
    vim +PluginInstall +qall

## Oh-My-Zsh (just a git submodule)

    git submodule update --init --recursive
    chsh -s /bin/zsh

## Python VirtualEnv

    mac    - sudo easy_install pip
    ubuntu - sudo apt-get install python-pip

    sudo pip install virtualenv
    mkdir ~/.virtualenvs
    sudo pip install virtualenvwrapper
    
    python -m virtualenv [-p python3] project_name

## Notes
### iTerm
If colors don't look right with iTerm on new install, uncheck "Draw bold text
in bright colors" in the Profiles tab of iTerm.

### Zsh
To see the order things are executed, use the `zsh -xv` command.
