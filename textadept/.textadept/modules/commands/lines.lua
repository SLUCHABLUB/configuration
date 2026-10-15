-- Commands acting on the lines touched by the selection.

local lines = {}

local function selected_lines()
	local first_line = buffer:line_from_position(buffer.selection_start)
	local last_line = buffer:line_from_position(buffer.selection_end)

	-- A selection ending at the start of a line does not include that line.
	local ends_at_line_start = buffer.selection_end == buffer:position_from_line(last_line)
	if last_line > first_line and ends_at_line_start then last_line = last_line - 1 end

	return first_line, last_line
end

-- The empty line after a final newline does not count as content.
local function last_content_line()
	local last_line = buffer.line_count
	local last_line_is_empty = buffer:position_from_line(last_line) == buffer.length + 1

	return last_line_is_empty and last_line - 1 or last_line
end

local function selection_is_at_start()
	local first_line = selected_lines()
	return first_line <= 1
end

local function selection_is_at_end()
	local _, last_line = selected_lines()
	return last_line >= last_content_line()
end

-- Repeats a command that moves the selected lines until they have reached a limit.
local function move_lines_until(move_command, has_reached_limit)
	return function()
		buffer:begin_undo_action()
		while not has_reached_limit() do move_command(buffer) end
		buffer:end_undo_action()
	end
end

function lines.delete()
	local first_line, last_line = selected_lines()
	local start_position = buffer:position_from_line(first_line)
	local end_position = buffer:position_from_line(last_line + 1)

	buffer:delete_range(start_position, end_position - start_position)
end

lines.move_to_start = move_lines_until(buffer.move_selected_lines_up, selection_is_at_start)
lines.move_to_end = move_lines_until(buffer.move_selected_lines_down, selection_is_at_end)

return lines
