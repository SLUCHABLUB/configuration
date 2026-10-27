local lsp = require('lsp')

local CODEBOOK = 'codebook-lsp serve'

-- The LSP module runs one server per language,
-- so codebook also replaces Textadept's own Lua server.
for _, language in ipairs(lexer.names()) do
    lsp.server_commands[language] = CODEBOOK
end

-- By default diagnostics are hidden around the caret.
lsp.show_all_diagnostics = true

-- Codebook has no completions,
-- and the LSP module errors on every typed character when a server lacks them.
lsp.show_completions = false

local TEXT_CHANGES = buffer.MOD_INSERTTEXT | buffer.MOD_DELETETEXT

-- Every second the LSP module resends edited buffers, but only those that already have diagnostics.
-- Pretending every edited buffer has old diagnostics also gets new typos in clean buffers marked.
local function request_diagnostics_after_edit(_, modification)
    if modification & TEXT_CHANGES ~= 0 then buffer._lsp_diagnostic_time = 0 end
end

events.connect(events.MODIFIED, request_diagnostics_after_edit)

local running_servers = {}

local function remember_server(_, server) running_servers[#running_servers + 1] = server end

-- Codebook ignores the exit notification the LSP module sends on quit,
-- and only exits once its input is closed.
-- Textadept waits for it to exit, so quitting would freeze.
local function close_server_inputs()
    for _, server in ipairs(running_servers) do server.proc:close() end
end

events.connect(events.LSP_INITIALIZED, remember_server)
events.connect(events.QUIT, close_server_inputs)

-- The LSP module only styles error messages,
-- so the other diagnostic messages would look like the file's own text.
local function style_diagnostic_message(_, modification, _, _, _, line)
    if modification & buffer.MOD_CHANGEANNOTATION == 0 then return end

    local style = buffer.annotation_style[line]
    local is_styled = style == view.STYLE_CALLTIP or style == buffer:style_of_name(lexer.ERROR)
    if not is_styled then
        buffer.annotation_style[line] = view.STYLE_CALLTIP
    end
end

events.connect(events.MODIFIED, style_diagnostic_message)
