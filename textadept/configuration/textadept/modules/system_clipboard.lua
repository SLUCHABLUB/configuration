local kitty = require('kitty')

local clipboard = textadept.clipboard

-- Textadept's default "wl-copy -f" owns the copied text until textadept kills it a second later,
-- which empties the clipboard.
-- Kitty instead keeps the text for as long as it runs,
-- and the kitten exits as soon as it has passed the text on.
if kitty.is_terminal then clipboard.copy_command = 'kitten clipboard' end
