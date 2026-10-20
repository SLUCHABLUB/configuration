-- By default the terminal version expects a block cursor,
-- so it moves the cursor onto the last selected character and leaves the caret's character unselected.
-- Placing the cursor at the caret and selecting every character suits kitty's bar cursor instead.
-- This also stops textadept from hiding the cursor when the caret scrolls out of view.
local BAR_CURSOR_CARET = view.CARETSTYLE_BLOCK_AFTER

local function use_bar_cursor_caret(target_view) target_view.caret_style = BAR_CURSOR_CARET end

events.connect(events.INITIALIZED, function()
	for _, existing_view in ipairs(_VIEWS) do use_bar_cursor_caret(existing_view) end
end)
events.connect(events.VIEW_NEW, function() use_bar_cursor_caret(view) end)
