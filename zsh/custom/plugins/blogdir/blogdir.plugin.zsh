b() { cd ~/Documents/Blog/$1;  }

_b() { _files -W ~/Documents/Blog -/; }
compdef _b b
