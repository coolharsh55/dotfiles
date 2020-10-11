# dotfiles
My public dotfiles

## installation notes

### dependencies

1. git
2. python3
3. tmux
4. xfce
5. i3

### external tools
1. insync
2. thunderbird
3. emacs
4. vim
5. zotero
6. firefox
7. spotify
8. clementine
9. libreoffice
10. sublime-text
11. sublime-merge

### stow

`stow {target}` will create symlink to `~/target` 

Because the structures in some of the folders are nested, stow will create links in the parent folder instead. To resolve this, use:

`stow -nv {command}` to test effects

`stow -S {target} -t ~`  or `stow -S {target} -d . -t ~` 

### emacs

For emacs, consider adding packages declared for use in the config, otherwise loading emacs will cause parsing errors in config.

### vim

Install vim-plug and execute `PlugInstall` from vim

## todo

* add thunderbird config
* add thunderbird addons + config
* add sublime text config
* add sublime text addons + config