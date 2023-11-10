# Add local binaries to PATH
fish_add_path $HOME/.local/bin

# Add the path to personal scripts to PATH
fish_add_path $HOME/scripts

# Add the path to Programs to PATH
fish_add_path $HOME/programs

# Add the path to rust binaries to PATH
fish_add_path $HOME/.cargo/bin

# Add Aiken to PATH
fish_add_path $HOME/.aiken/bin

# Add the path to go binaries to PATH
fish_add_path $HOME/go/bin

# Load conda if installed
fish_add_path $HOME/miniforge3/bin
if type -q conda
    eval conda "shell.fish" "hook" $argv | source
end
if test -f "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
    source "$HOME/miniforge3/etc/fish/conf.d/mamba.fish"
end

# Load jenv if installed
fish_add_path $HOME/.jenv/bin
fish_add_path $HOME/.jenv/shims

# Add Matlab installed locally
fish_add_path $HOME/programs/matlab/bin

# Add Cuda if installed
fish_add_path /opt/cuda/bin

# Add Deno if installed
set -gx DENO_INSTALL $HOME/.deno
fish_add_path $DENO_INSTALL/bin

# Use starship prompt
if type -q starship
  starship init fish | source
end

# Enable direnv if installed
if type -q direnv
  direnv hook fish | source
end

# Use zoxide smarter cd
if type -q zoxide
  zoxide init fish | source
end

# Configure fnm if available (fast node manager)
if type -q fnm
  fnm env --use-on-cd | source
end

# Configure pnpm (faster npm)
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# Setup X Server if within WSL
if grep -q -i wsl /proc/version
  set ip (ip route list default | string split ' ' | head -n 3 | tail -n 1)
  set -gx DISPLAY $ip:0
  set -gx LIBGL_ALWAYS_INDIRECT 1
end

# Some useful aliases
alias ll "ls -l"
alias la "ls -la"

# Some aliases for command line tools
# CF that nice article: https://zaiste.net/posts/shell-commands-rust/
alias cat bat
alias ls eza
alias hx helix
alias ps procs
# alias docker podman
# alias grep rg    # better use rg directly actually
# alias cloc tokei # better use tokei directly actually
# alias find fd    # better use fd directly actually
# alias sed sd     # better use sd directly actually
# alias top btm    # better use btm directly actually

# alias du dust        # better use dust directly actually
# alias time hyperfine # better use hyperfine directly actually
