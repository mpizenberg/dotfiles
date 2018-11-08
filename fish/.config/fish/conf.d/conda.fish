set _CONDA_EXE "/home/matthieu/miniconda3/bin/conda"
set _CONDA_ROOT "/home/matthieu/miniconda3"

#
# INSTALL
#
#     Source this file from the fish shell to enable activate / deactivate functions.
#     In order to automatically load these functions on fish startup, append
#
#         source [CONDA_INSTALL_LOCATION]/etc/fish/conf.d/conda.fish
#
#     to the end of your ~/.config/config.fish file, or
#
#         sudo ln -s [CONDA_INSTALL_LOCATION]/etc/fish/conf.d/conda.fish /etc/fish/conf.d/conda.fish
#
#     If you are using fish as your default shell and want any environment activated by default also add
#
#         conda activate <env-name>
#
#     For example add 
#    
#         conda acitvate base
#   
#     to have the default environment running as in bash.
#



# source shell/etc/fish/conf.d/conda.fish

# For testing only. $_CONDA_EXE is added as top line in this file under normal installs.
test -n "$_CONDA_EXE"; or set _CONDA_EXE "$PWD/shell/bin/conda"

test -n "$CONDA_SHLVL"; or set -gx CONDA_SHLVL "0"

function __conda_add_prompt
  if set -q CONDA_DEFAULT_ENV
      set_color normal
      echo -n '('
      set_color -o green
      echo -n $CONDA_DEFAULT_ENV
      set_color normal
      echo -n ') '
  end
end

if functions -q fish_prompt
    functions -c fish_prompt __fish_prompt_orig
    functions -e fish_prompt
else
    function __fish_prompt_orig
    end
end

function return_last_status
  return $argv
end

function fish_prompt
  set -l last_status $status
  if set -q CONDA_LEFT_PROMPT
      __conda_add_prompt
  end
  return_last_status $last_status
  __fish_prompt_orig
end

if functions -q fish_right_prompt
    functions -c fish_right_prompt __fish_right_prompt_orig
    functions -e fish_right_prompt
else
    function __fish_right_prompt_orig
    end
end
function fish_right_prompt
  if not set -q CONDA_LEFT_PROMPT
      __conda_add_prompt
  end
  __fish_right_prompt_orig
end


function conda --inherit-variable _CONDA_EXE
    if [ (count $argv) -lt 1 ]
        eval $_CONDA_EXE
    else
        set -l cmd $argv[1]
        set -e argv[1]
        switch $cmd
            case activate
                eval (eval $_CONDA_EXE shell.fish activate $argv)
            case deactivate
                eval (eval $_CONDA_EXE shell.fish deactivate $argv)
            case install update remove uninstall
                eval $_CONDA_EXE $cmd $argv
                and eval (eval $_CONDA_EXE shell.fish reactivate)
            case '*'
                eval $_CONDA_EXE $cmd $argv
        end
    end
end




# Autocompletions below


# Faster but less tested (?)
function __fish_conda_commands
  string replace -r '.*_([a-z]+)\.py$' '$1' $_CONDA_ROOT/lib/python*/site-packages/conda/cli/main_*.py
  echo activate
  echo deactivate
end

function __fish_conda_envs
  conda config --show envs_dirs | awk 'NR > 1 {print $2}' | xargs -IX find X -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | sort
end

function __fish_conda_packages
  conda list | awk 'NR > 3 {print $1}'
end

function __fish_conda_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'conda' ]
    return 0
  end
  return 1
end

function __fish_conda_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

# Conda commands
complete -f -c conda -n '__fish_conda_needs_command' -a '(__fish_conda_commands)'

# Commands that need environment as parameter
complete -f -c conda -n '__fish_conda_using_command activate' -a '(__fish_conda_envs)'

# Commands that need package as parameter
complete -f -c conda -n '__fish_conda_using_command remove' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command upgrade' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command update' -a '(__fish_conda_packages)'
