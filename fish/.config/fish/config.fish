# Add the path to personal scripts to PATH
add_to_path $HOME/scripts

# Add the path to Programs to PATH
add_to_path $HOME/programs

# Add the path to local binaries to PATH
add_to_path $HOME/.local/bin

# Add the path to rust binaries to PATH
add_to_path $HOME/.cargo/bin

# Add the path to go binaries to PATH
add_to_path $HOME/go/bin

# Load conda if installed
add_to_path $HOME/miniconda3/bin
add_to_path $HOME/anaconda3/bin
if type -q conda
  eval conda "shell.fish" "hook" $argv | source
end

# Load jenv if installed
add_to_path $HOME/.jenv/bin
add_to_path $HOME/.jenv/shims

# Add Matlab installed locally
add_to_path $HOME/programs/matlab/bin

# Add Cuda if installed
add_to_path /opt/cuda/bin

# Use starship prompt
if type -q starship
  starship init fish | source
end

# Enable direnv if installed
if type -q direnv
  direnv hook fish | source
end

# Enable zoxide if installed
if type -q zoxide
  zoxide init fish | source
end

# Configure fnm if available (fast node manager)
if type -q fnm
  fnm env --use-on-cd | source
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
alias ls eza
alias hx helix
alias ps procs
# alias grep rg    # better use rg directly actually
# alias cloc tokei # better use tokei directly actually
# alias find fd    # better use fd directly actually
# alias sed sd     # better use sd directly actually
# alias top btm    # better use btm directly actually

# alias du dust        # better use dust directly actually
# alias time hyperfine # better use hyperfine directly actually
