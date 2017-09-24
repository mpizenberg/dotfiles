# Add the path to perl scripts to PATH
set PATH /usr/bin/vendor_perl $PATH
# Add the path to haskell cabal binaries to PATH
set PATH $HOME/.cabal/bin $PATH
# Add the path to rust binaries to PATH
set PATH $HOME/.cargo/bin $PATH
# Add the path to ruby gems binaries to PATH
set PATH $HOME/.gem/ruby/2.4.0/bin $PATH
# Add the path to Conda (python) to PATH
set PATH $HOME/miniconda3/bin $PATH
# Add the path to personal scripts to PATH
set PATH $HOME/scripts $PATH

# use default desktop opener in nnn
set NNN_FALLBACK_OPENER xdg-open

# Load conda if installed
set --local conda_path $HOME/miniconda3/etc/fish/conf.d/conda.fish
if test -e $conda_path
	source $conda_path
end
