# Use starship prompt
starship init fish | source

# Add the path to personal scripts to PATH
add_to_path $HOME/scripts

# Add the path to Programs to PATH
add_to_path $HOME/programs

# Add the path to rust binaries to PATH
add_to_path $HOME/.cargo/bin

# Load conda if installed
add_to_path $HOME/miniconda3/bin
add_to_path $HOME/anaconda3/bin
eval conda "shell.fish" "hook" $argv | source

# Load jenv if installed
add_to_path $HOME/.jenv/bin
add_to_path $HOME/.jenv/shims

# Add Matlab installed locally
add_to_path $HOME/programs/matlab/bin

# Add Cuda if installed
add_to_path /opt/cuda/bin

# Enable direnv if installed
if type -q direnv
    direnv hook fish | source
end

# Enable zoxide if installed
if type -q zoxide
    zoxide init fish | source
end

# Setup X Server if within WSL
if grep -q -i wsl /proc/version
    set ip (ip route list default | string split ' ' | head -n 3 | tail -n 1)
    set -gx DISPLAY $ip:0
    set -gx LIBGL_ALWAYS_INDIRECT 1
end

# Some aliases for command line tools
# CF that nice article: https://zaiste.net/posts/shell-commands-rust/
alias cat bat
alias ls exa
alias hx helix
alias ps procs
# alias grep rg    # better use rg directly actually
# alias cloc tokei # better use tokei directly actually
# alias find fd    # better use fd directly actually
# alias sed sd     # better use sd directly actually
# alias top btm    # better use btm directly actually

# alias du dust        # better use dust directly actually
# alias time hyperfine # better use ytop directly actually

# Created by `pipx` on 2023-03-27 08:47:16
set PATH $PATH /home/matthieu/.local/bin

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/home/matthieu/programs/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/matthieu/micromamba"
$MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
