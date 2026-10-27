-- Deletion behind the cursor, which deletes the selection instead if there is one.

local deletion = {}

local function delete_selection_or(command)
	return function()
		if buffer.selection_empty then
			command(buffer)
		else
			buffer:replace_sel('')
		end
	end
end

deletion.delete_selection_or_word = delete_selection_or(buffer.del_word_left)
deletion.delete_selection_or_to_line_start = delete_selection_or(buffer.del_line_left)

return deletion
