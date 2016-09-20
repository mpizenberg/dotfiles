function _git_branch_name
	echo (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
end

function _git_is_dirty
	echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

# Show git branch and status if in a git repository
function _git_info
	set -l yellow (set_color yellow --bold)
	set -l green (set_color green --bold)
	set -l normal (set_color normal --bold)
	if [ (_git_branch_name) ]
		set -l git_branch (_git_branch_name)
		if [ (_git_is_dirty) ]
			set git_info '(' $yellow $git_branch "±" $normal ')'
		else
			set git_info '(' $green $git_branch $normal ')'
		end
		echo -n -s ' · ' $git_info $normal
	end
end

# Display [venvname] if in a virtualenv
function _venv_info
	if set -q VIRTUAL_ENV
		echo -n -s '[' (basename "$VIRTUAL_ENV") '] '
	end
end

function fish_prompt
	# Cache exit status
	set -l last_status $status
	
	# Variables aliases to change color
	set -l red (set_color red --bold)
	set -l magenta (set_color magenta --bold)
	set -l cyan (set_color cyan --bold)
	set -l normal (set_color normal --bold)

	# Get a shorter version of home path
	set -l cwd (pwd | sed "s:^$HOME:~:")

	# Print first line of prompt
	echo -n -s '# ' $cyan $USER $normal ' @ ' $cyan (hostname) $normal ' · [' $magenta $cwd $normal ']' (_git_info)

	# Terminate with a nice prompt char
	set -l prompt_color $red
	set -l prompt_status (echo -n -s '[' $last_status '] ')
	if test $last_status = 0
		set prompt_color $normal
		set -e prompt_status
	end

	echo ''
	echo -n -s $prompt_color $prompt_status '$ ' $normal
end
