# Add the path to personal scripts to PATH
add_to_path $HOME/scripts

# Add the path to Programs to PATH
add_to_path $HOME/programs

# Add the path to rust binaries to PATH
add_to_path $HOME/.cargo/bin

# Add the path to go binaries to PATH
add_to_path $HOME/go/bin

# Load conda if installed
add_to_path $HOME/miniconda3/bin

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

# Use zoxide smarter cd
if type -q zoxide
  zoxide init fish | source
end

# Configure fnm if available (fast node manager)
if type -q fnm
  fnm env --use-on-cd | source
end

# Some aliases for command line tools
# CF that nice article: https://zaiste.net/posts/shell-commands-rust/
alias cat bat
alias ls exa
alias hx helix
# alias grep rg    # better use rg directly actually
# alias cloc tokei # better use tokei directly actually
# alias find fd    # better use fd directly actually
# alias sed sd     # better use sd directly actually
# alias top ytop   # better use ytop directly actually
