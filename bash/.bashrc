# Source global definitions
f=/etc/bashrc && [ -f $f ] && source $f

# Prompt
export PS1="\[\e[00;32m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;36m\]\w\[\e[0m\]\[\e[00;37m\]]\[\e[0m\]\[\e[00;35m\]\\$ \[\e[0m\]"

# Alias definitions in .bash_aliases file
f=$HOME/.bash_aliases && [ -f $f ] && source $f

# Autocompletion for Git
f=$HOME/.git-completion.bash && [ -f $f ] && source $f

# Activate fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
