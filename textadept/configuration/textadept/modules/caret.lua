-- By default the terminal version expects a block cursor,
-- so it moves the cursor onto the last selected character and leaves the character under the caret unselected.
-- This places the cursor at the caret and selects every character,
-- so the caret behaves like a bar even when the terminal draws a block.

local views = require('views')

local BAR_CURSOR_CARET = view.CARETSTYLE_BLOCK_AFTER

views.for_each(function(target_view) target_view.caret_style = BAR_CURSOR_CARET end)
