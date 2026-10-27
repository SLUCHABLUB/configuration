-- Changing how the buffer is displayed.

local view_commands = {}

function view_commands.toggle_word_wrap()
	local is_wrapping = view.wrap_mode ~= view.WRAP_NONE
	view.wrap_mode = is_wrapping and view.WRAP_NONE or view.WRAP_WORD
end

return view_commands
