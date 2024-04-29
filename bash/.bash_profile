f=$HOME/.bashrc && [ -f $f ] && source $f

export PATH="$HOME/.cargo/bin:$PATH"

source /home/matthieu/.config/broot/launcher/bash/br
. "$HOME/.cargo/env"
