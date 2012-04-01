b() { cd ~/Blog/$1;  }

_b() { _files -W ~/Blog -/; }
compdef _b b
