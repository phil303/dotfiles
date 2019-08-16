## Installation

    git clone git@github.com:phil303/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    # setup dev environment
    ./install.py

## Oh-My-Zsh (just a git submodule)

    git submodule update --init --recursive
    chsh -s /bin/zsh

## Python VirtualEnv

    python3 -m venv ~/.virtualenvs/<name>

    # to activate
    . ~/.virtualenvs/<name>/bin/activate

## Notes
### iTerm
If colors don't look right with iTerm on new install, uncheck "Draw bold text
in bright colors" in the Profiles tab of iTerm.

### Zsh
To check shell start up times:

    for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done

To see the order things are executed, use the `zsh -xv` command.
