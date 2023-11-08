# Source global definitions
f=/etc/bashrc && [ -f $f ] && source $f

# Prompt
export PS1="\[\e[00;32m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]]\[\e[0m\]\[\e[00;35m\]\\$ \[\e[0m\]"

# Alias definitions in .bash_aliases file
f=$HOME/.bash_aliases && [ -f $f ] && source $f

# Autocompletion for Git
f=$HOME/.git-completion.bash && [ -f $f ] && source $f

# Starship prompt
eval "$(starship init bash)"

source /home/matthieu/.config/broot/launcher/bash/br

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/matthieu/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/matthieu/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/matthieu/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/matthieu/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/matthieu/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/matthieu/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

