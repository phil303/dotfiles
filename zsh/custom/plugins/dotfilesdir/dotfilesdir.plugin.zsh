dot() { cd ~/.dotfiles/$1;  }

_dot() { _files -W ~/.dotfiles -/; }
compdef _dot dot
