-- Opening files and going to places in them.

local files = {}

local LINE_AND_COLUMN_PATTERN = '^(%d+):?(%d*)$'
local FILE_LINE_AND_COLUMN_PATTERN = '^(.-):(%d+):?(%d*)$'

-- Returns the file, line and column of a go to target, all of which may be nil.
local function parse_go_to_target(target)
    local line, column = target:match(LINE_AND_COLUMN_PATTERN)
    if line then return nil, tonumber(line), tonumber(column) end

    local file
    file, line, column = target:match(FILE_LINE_AND_COLUMN_PATTERN)
    if file then return file, tonumber(line), tonumber(column) end

    return target, nil, nil
end

local function go_to_line(line, column)
    view:ensure_visible_enforce_policy(line)
    buffer:goto_pos(buffer:find_column(line, column or 1))
end

function files.go_to()
    local target = ui.dialogs.input{title = 'Go to file or line:'}
    if not target or target == '' then return end

    local file, line, column = parse_go_to_target(target)

    if file then io.open_file(file) end
    if line then go_to_line(line, column) end
end

function files.open_settings() io.open_file(_USERHOME .. '/init.lua') end

return files
