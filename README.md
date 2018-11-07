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

I'm using fisherman to manage fish plugins.
After using `stow`, go into config folder and install plugins with:

```shell
cat fishfile | fisher add
```

## nvim / vim

I'm using Plug to manage neovim / vim plugins.
After using `stow` and launching nvim / vim, install plugins with:

```vim
:PlugInstall
```

## tmux

I'm using tpm to manage tmux plugins.
After using `stow` and launching a tmux, install plugins with:

```tmux
prefix + I
```
