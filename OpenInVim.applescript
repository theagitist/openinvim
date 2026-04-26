on open theFiles
	set fileArgs to ""
	set firstName to ""
	repeat with theFile in theFiles
		set filePath to POSIX path of theFile
		set fileArgs to fileArgs & " '" & filePath & "'"
		if firstName is "" then
			-- Extract just the filename
			set firstName to do shell script "basename " & quoted form of filePath
		end if
	end repeat

	-- Check if tmux has active sessions
	set hasTmux to false
	try
		do shell script "/opt/homebrew/bin/tmux list-sessions 2>/dev/null"
		set hasTmux to true
	end try

	if hasTmux then
		do shell script "/opt/homebrew/bin/tmux new-window -n " & quoted form of firstName & " '/opt/homebrew/bin/vim" & fileArgs & "'"
		do shell script "open -a iTerm"
	else
		set tmpFile to do shell script "mktemp /tmp/vim_open.XXXXXX"
		set cmdFile to tmpFile & ".command"
		do shell script "mv " & tmpFile & " " & cmdFile

		do shell script "cat > " & cmdFile & " << 'INNEREOF'
#!/bin/bash
rm -f " & cmdFile & "
exec /opt/homebrew/bin/vim" & fileArgs & "
INNEREOF"

		do shell script "chmod +x " & cmdFile
		do shell script "open -a iTerm " & cmdFile
	end if
end open

on run
	do shell script "open -a iTerm"
end run
