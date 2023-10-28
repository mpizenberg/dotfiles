# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.default-config-dir)
]

# Helper function for PATH
def prepend_uniq [new_path: string, all_paths: list] {
    let full_path = ($new_path | path expand)
    if ($new_path | path exists) and (not ($full_path in $all_paths)) {
        $all_paths | prepend $full_path
    } else {
        $all_paths
    }
}

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
mut env_path = ($env.PATH | split row (char esep))
$env_path = (prepend_uniq '~/.local/bin' $env_path) # local binaries
$env_path = (prepend_uniq '~/scripts' $env_path) # personal scripts
$env_path = (prepend_uniq '~/programs' $env_path) # local programs
$env_path = (prepend_uniq '~/.cargo/bin' $env_path) # rust binaries
$env_path = (prepend_uniq '~/.aiken/bin' $env_path) # aiken
$env_path = (prepend_uniq '~/go/bin' $env_path) # go
$env_path = (prepend_uniq '~/miniconda3/bin' $env_path) # conda stuff
$env_path = (prepend_uniq '~/anaconda3/bin' $env_path) # conda stuff
$env_path = (prepend_uniq '~/.jenv/bin' $env_path) # jenv
$env_path = (prepend_uniq '~/.jenv/shims' $env_path) # jenv
$env_path = (prepend_uniq '~/programs/matlab/bin' $env_path) # matlab
$env_path = (prepend_uniq '/opt/cuda/bin' $env_path) # cuda
$env.DENO_INSTALL = ("~/.deno" | path expand) # deno
$env_path = (prepend_uniq $'($env.DENO_INSTALL)/bin' $env_path) # deno
$env.PNPM_HOME = ("~/.local/share/pnpm" | path expand) # pnpm
$env_path = (prepend_uniq $'($env.PNPM_HOME)' $env_path) # pnpm
$env.PATH = $env_path

# Starship prompt stuff
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Zoxide stuff
zoxide init nushell | save -f ~/.zoxide.nu
