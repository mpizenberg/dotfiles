# Nu shell config
$env.config = {
    show_banner: false,
    rm: { always_trash: true },
    table: { mode: light }, # default, markdown
}

# Conda stuff
$env.CONDA_NO_PROMPT = true

# Aliases for ls
alias lsnu = ls
def ls [dir?: string] {
    lsnu (if $dir == null { "" } else { $dir }) | sort-by type name -i | grid -c
}
def la [dir?: string] {
    lsnu -la (if $dir == null { "" } else { $dir }) | sort-by type name -i | select mode name target size modified
}
def ll [dir?: string] {
    lsnu -l (if $dir == null { "" } else { $dir }) | sort-by type name -i | select mode name target size modified
}

# Sink that prints table in markdown
def table_md [] {
    let in_table = $in; $env.config.table.mode = markdown; $in_table | table
}

# Aliases for CLI tools
alias hx = helix
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
source ~/.zoxide.nu

# Broot stuff
source /home/matthieu/.config/broot/launcher/nushell/br

# fnm stuff
source fnm.nu
