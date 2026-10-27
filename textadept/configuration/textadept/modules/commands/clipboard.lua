-- Copying and pasting where a line copied without a selection is pasted as a line of its own.

local clipboard = {}

-- The text of the last line copied or cut without a selection.
-- Pasting exactly this text inserts it as a new line above the cursor.
local copied_line

local function current_line() return buffer:line_from_position(buffer.current_pos) end

-- Wraps a command that copies or cuts the selection, or the current line if nothing is selected.
local function remembering_copied_line(command)
    return function()
        local is_line_copy = buffer.selection_empty

        command(buffer)

        -- Read what was just copied from textadept's internal clipboard,
        -- since the system clipboard is set by a separate command that may not have finished yet.
        copied_line = is_line_copy and ui.get_clipboard_text(true) or nil
    end
end

local function paste_above_current_line(text)
    local line = current_line()
    local column = buffer.column[buffer.current_pos]

    buffer:insert_text(buffer:position_from_line(line), text)

    -- Keep the cursor on the same text, which has moved down a line.
    buffer:goto_pos(buffer:find_column(line + 1, column))
end

clipboard.copy_selection_or_line = remembering_copied_line(buffer.copy_allow_line)
clipboard.cut_selection_or_line = remembering_copied_line(buffer.cut_allow_line)

function clipboard.paste()
    local text = ui.get_clipboard_text()

    if text == copied_line then
        paste_above_current_line(text)
    else
        buffer:paste()
    end
end

return clipboard
