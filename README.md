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
You can use the already patched nerdfont [Fira Mono][fira-mono-font], [Ubuntu Mono][ubuntu-mono-font].
Make sure to use it in your terminal preferences.

[ubuntu-mono-font]: https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/UbuntuMono.zip
[fira-mono-font]: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip

To install config files, I use GNU stow.
To install vim config files for example:

```shell
stow -t ~ vim --no-folding
```

## fish

I'm using [fisher](https://github.com/jorgebucaran/fisher) to manage fish plugins.

```shell
stow -t ~ fish --no-folding
fisher self-update
fisher
```

## nvim / vim

I'm using [Plug](https://github.com/junegunn/vim-plug) to manage neovim / vim plugins.

```shell
stow -t ~ vim --no-folding
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
stow -t ~ tmux --no-folding
tmux
prefix + I
```

## Windows WSL

For wsl, small changes are necessary since there is no GUI.
For git, we can install Meld on windows, add it to the windows PATH and modify the merge tool section as follows:

```
[merge]
tool = meld
[mergetool "meld"]
path = Meld.exe
```

For wezterm, I start directly zellij inside wsl with:

```lua
return {
  default_prog = {"wsl", "zellij", "attach", "--create"},
  ...
}
```
