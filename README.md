# Dotfiles

This repo contains my configuration files.
Each directory corresponds to a program.
The content of each directory directly maps
the hierarchy of files from the home directory.

Some programs require submodules,
so make sure to clone with submodules:

```shell
git clone --recursive git@github.com:mpizenberg/dotfiles.git
```

Some configurations require the use of powerline fonts / nerdfonts.
You can use the already patched nerdfont [Ubuntu Mono][ubuntu-mono-font].
Make sure to use it in your terminal preferences.

[ubuntu-mono-font]: https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/UbuntuMono.zip

To install config files, I use GNU stow.
To install vim config files for example:

```shell
stow vim --no-folding
```

## fish

I'm using [fisher](https://github.com/jorgebucaran/fisher) to manage fish plugins.

```shell
stow fish --no-folding
fisher self-update
fisher
```

## nvim / vim

I'm using [Plug](https://github.com/junegunn/vim-plug) to manage neovim / vim plugins.

```shell
stow vim --no-folding
vim
:PlugUpgrade
:PlugInstall
```

## tmux

I'm using [tpm](https://github.com/tmux-plugins/tpm) to manage tmux plugins.

```shell
cd tmux/.tmux/plugins/tpm
git pull origin master
cd ../../../..
stow tmux --no-folding
tmux
prefix + I
```
