load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

# Add dynamic FNM path
$env.PATH = ($env.PATH | append [
  $"($env.FNM_MULTISHELL_PATH)/bin"
])
