-- Starting without files opens an untitled buffer and saving it asks for a filename.

-- The last session is only loaded when it is also saved.
textadept.session.save_on_quit = false

-- The terminal version's save dialog is a file browser that appends the typed name to the directory.
local function prompt_for_filename(options)
	local filename = ui.dialogs.input{title = options.title, text = options.file}
	if not filename or filename == '' then return nil end

	return lfs.abspath(filename, options.dir)
end

ui.dialogs.save = prompt_for_filename
