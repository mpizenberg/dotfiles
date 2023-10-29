# Nu shell config
$env.config = {
    show_banner: false,
    rm: { always_trash: true }
}

# Conda stuff
$env.CONDA_NO_PROMPT = true

# Aliases for commands
alias ll = ls -l
alias la = ls -la
alias hx = helix

# Aliases for CLI tools
alias cat = bat
# alias docker = podman
# alias grep = rg
# alias cloc = tokei
# alias find = fd
# alias sed = sd
# alias top = btm
# alias du = dust
# alias time = hyperfine

# Starship prompt stuff
use ~/.cache/starship/init.nu

# Zoxide stuff
# source ~/.zoxide.nu

# Broot stuff
source /home/matthieu/.config/broot/launcher/nushell/br
