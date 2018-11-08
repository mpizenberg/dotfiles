function add_to_path
	if test -d $argv
		if not contains -- $argv $PATH
			set PATH $argv $PATH
		end
	end
end
