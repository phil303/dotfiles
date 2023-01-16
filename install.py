#!/usr/bin/env python3
import argparse
import os
import subprocess

SYMLINKS = [
    'gitignore',
    'vimrc',
    'vim',
    'zshrc',
    'zsh',
]

BREW_PACKAGES = [
    'git',
    'git-delta',
    'ripgrep',
    'asdf'
]

GIT_CONFIG_NAME = "Phil Aquilina"
GIT_CONFIG_EMAIL = "philaquilina@gmail.com"

HOME_DIR = os.path.expanduser('~')

def install(specific_modules):
    for mod in specific_modules:
        try:
            MODULES[mod]()
            print("Finished setting up %s." % mod)
        except KeyError:
            print("Unable to find module named %s." % mod)

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
        reply = input("gitconfig already exists. Overwrite? ")
        overwrite = len(reply) > 0 and reply[0].lower() == "y"
        if not overwrite:
            return

    with open(git_config_path, 'w') as f:
        print("Writing gitconfig")
        f.write(GIT_CONFIG)


def install_brew():
    subprocess.run(["/bin/bash", "-c", "\"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""])


def install_brew_packages():
    subprocess.run(["brew", "install", ' '.join(BREW_PACKAGES)])


def setup_vim_plugins():
    subprocess.run(["mkdir", "vim/bundle"])
    subprocess.run(["git", "clone", "https://github.com/gmarik/vundle.git", "~/.vim/bundle/vundle"])
    subprocess.run(["vim", "+PluginInstall", "+qall"])


def setup_virtualenvs_directory():
    subprocess.run(["mkdir", "~/.virtualenvs"])


MODULES = {
  'symlinks': create_symlinks,
  'gitconfig': create_gitconfig,
  'brew': install_brew,
  'brew-packages': install_brew_packages(),
  'vim': setup_vim_plugins,
  'virtualenv': setup_virtualenvs_directory,
}


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

[delta]
  features = decorations
[delta "decorations"]
  commit-decoration-style = bold yellow box ul
  file-style = bold yellow ul
  file-decoration-style = none
  hunk-header-decoration-style = yellow box
""".format(name=GIT_CONFIG_NAME, email=GIT_CONFIG_EMAIL)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Setup development environment.')
    parser.add_argument(
        'modules',
        type=str,
        nargs='*',
        default=list(MODULES.keys()),
        help='Install specific modules. Options are: %s.' % ", ".join(MODULES.keys()),
    )
    args = parser.parse_args()
    install(args.modules)
