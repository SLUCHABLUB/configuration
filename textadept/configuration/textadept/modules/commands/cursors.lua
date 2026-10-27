-- Adding cursors above the topmost or below the bottommost cursor.

local cursors = {}

local UP = -1
local DOWN = 1

local function outermost_caret(direction)
	local outermost

	for selection_number = 1, buffer.selections do
		local caret = buffer.selection_n_caret[selection_number]
		local is_further = not outermost or (caret - outermost) * direction > 0
		if is_further then outermost = caret end
	end

	return outermost
end

-- Returns whether a cursor was added.
local function add_cursor(direction)
	local caret = outermost_caret(direction)
	local line = buffer:line_from_position(caret) + direction

	local is_outside_document = line < 1 or line > buffer.line_count
	if is_outside_document then return false end

	local position = buffer:find_column(line, buffer.column[caret])
	buffer:add_selection(position, position)

	return true
end

local function add_cursors_as_far_as_possible(direction)
	repeat until not add_cursor(direction)
end

function cursors.add_above() add_cursor(UP) end
function cursors.add_below() add_cursor(DOWN) end
function cursors.add_to_start() add_cursors_as_far_as_possible(UP) end
function cursors.add_to_end() add_cursors_as_far_as_possible(DOWN) end

return cursors
