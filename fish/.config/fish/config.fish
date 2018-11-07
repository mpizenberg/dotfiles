# Add the path to perl scripts to PATH
set PATH /usr/bin/vendor_perl $PATH
# Add the path to haskell cabal binaries to PATH
set PATH $HOME/.cabal/bin $PATH
# Add the path to rust binaries to PATH
set PATH $HOME/.cargo/bin $PATH
# Add the path to ruby gems binaries to PATH
set PATH $HOME/.gem/ruby/2.4.0/bin $PATH
# Add the path to personal scripts to PATH
set PATH $HOME/scripts $PATH
# Add the path to Programs to PATH
set PATH $HOME/programs $PATH

# use default desktop opener in nnn
set NNN_FALLBACK_OPENER xdg-open

# set RUST_SRC_PATH variable for racer (Rust completion tool)
set -x RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"
