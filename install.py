#!/usr/bin/env python2.7
import os

SYMLINKS = [
    'gitignore',
    'vimrc',
    'vim',
    'zshrc',
    'zsh',
]

GIT_CONFIG_NAME = "Phil Aquilina"
GIT_CONFIG_EMAIL = "philaquilina@gmail.com"

HOME_DIR = os.path.expanduser('~')

def install():
    create_symlinks()
    create_gitconfig()
    print("Finished installing dotfiles")
    setup_vim_plugins()
    print("Finished setting up Vim")
    setup_virtualenvs_directory()
    print("Finished setting up Python virtualenvs directory")


def create_symlinks():
    current_dir = os.path.dirname(os.path.realpath(__file__))

    for symlink in SYMLINKS:
        local_path = "%s/%s" % (current_dir, symlink)

        if not os.path.exists(local_path):
            print("%s does not exist" % symlink)
            continue

        sym_link_path = "%s/.%s" % (HOME_DIR, symlink)
        if os.path.exists(sym_link_path):
            os.remove(sym_link_path)

        print("Writing symlink for %s" % symlink)
        os.symlink(local_path, sym_link_path)


def create_gitconfig():
    git_config_path = "%s/.gitconfig" % HOME_DIR

    if os.path.exists(git_config_path):
        reply = raw_input("gitconfig already exists. Overwrite? ")
        overwrite = len(reply) > 0 and reply[0].lower() == "y"
        if not overwrite:
            return

    with open(git_config_path, 'w') as f:
        print("Writing gitconfig")
        f.write(GIT_CONFIG)


def setup_vim_plugins():
    os.system('mkdir vim/bundle')
    os.system('git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle')
    os.system('vim +PluginInstall +qall')


def setup_virtualenvs_directory():
    os.system('mkdir ~/.virtualenvs')


GIT_CONFIG = """[user]
  name = {name}
  email = {email}
[color]
  diff = auto
  status = auto
  branch = auto
[core]
  editor = vim
  autocrlf = input
  excludesfile = ~/.gitignore
[apply]
  whitespace = warn
[format]
  pretty = %Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen(%cd, %cr) %C(bold blue)<%an>%Creset
[credential]
  helper = osxkeychain
[diff]
  tool = opendiff
[push]
  default = simple
[filter "lfs"]
  clean = git-lfs clean %f
  smudge = git-lfs smudge %f
  required = true
""".format(name=GIT_CONFIG_NAME, email=GIT_CONFIG_EMAIL)



if __name__ == '__main__':
    install()
