# Nu shell config
$env.config = {
    show_banner: false,
    rm: { always_trash: true },
    table: { mode: light }, # default, markdown
}

# Conda stuff
$env.CONDA_NO_PROMPT = true

# IDS stuff
$env.GENICAM_GENTL32_PATH = "/opt/ids-peak_2.3.0.0-15823_amd64/lib/ids/cti"
$env.GENICAM_GENTL64_PATH = "/opt/ids-peak_2.3.0.0-15823_amd64/lib/ids/cti"

# Aliases for ls
alias _ls = ls
def ls [dir?: string] {
    _ls (if $dir == null { "" } else { $dir }) | sort-by type name -i | grid -c
}
def la [dir?: string] {
    _ls -la (if $dir == null { "" } else { $dir }) | sort-by type name -i | select mode name target size modified
}
def ll [dir?: string] {
    _ls -l (if $dir == null { "" } else { $dir }) | sort-by type name -i | select mode name target size modified
}

# Non recursive du
alias _du = du
def du [...args] {
    let parsed_args = if ($args | is-empty) { ["*"] } else { $args }
    $parsed_args | each { _du -a $in | select path apparent physical } | flatten | sort-by apparent --reverse
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
