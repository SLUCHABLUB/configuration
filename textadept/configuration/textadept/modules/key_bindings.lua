-- The bindings from the keybindings specification.

local clipboard = require('commands.clipboard')
local cursors = require('commands.cursors')
local deletion = require('commands.deletion')
local files = require('commands.files')
local lines = require('commands.lines')
local view_commands = require('commands.view')

keys['ctrl+a'] = buffer.select_all
keys['ctrl+c'] = clipboard.copy_selection_or_line
keys['ctrl+d'] = lines.delete
keys['ctrl+f'] = ui.find.focus
keys['ctrl+g'] = files.go_to
keys['ctrl+k'] = textadept.editing.toggle_comment
keys['ctrl+o'] = io.open_file
keys['ctrl+q'] = quit
keys['ctrl+s'] = buffer.save
keys['ctrl+u'] = view_commands.toggle_word_wrap
keys['ctrl+v'] = clipboard.paste
keys['ctrl+w'] = buffer.close
keys['ctrl+x'] = clipboard.cut_selection_or_line
keys['ctrl+y'] = buffer.redo
keys['ctrl+z'] = buffer.undo
keys['ctrl+,'] = files.open_settings

keys['up'] = buffer.line_up
keys['down'] = buffer.line_down
keys['left'] = buffer.char_left
keys['right'] = buffer.char_right
keys['shift+up'] = buffer.line_up_extend
keys['shift+down'] = buffer.line_down_extend
keys['shift+left'] = buffer.char_left_extend
keys['shift+right'] = buffer.char_right_extend

keys['ctrl+up'] = buffer.document_start
keys['ctrl+down'] = buffer.document_end
keys['ctrl+left'] = buffer.home
keys['ctrl+right'] = buffer.line_end
keys['ctrl+shift+up'] = buffer.document_start_extend
keys['ctrl+shift+down'] = buffer.document_end_extend
keys['ctrl+shift+left'] = buffer.home_extend
keys['ctrl+shift+right'] = buffer.line_end_extend

keys['meta+up'] = buffer.move_selected_lines_up
keys['meta+down'] = buffer.move_selected_lines_down
keys['ctrl+meta+up'] = lines.move_to_start
keys['ctrl+meta+down'] = lines.move_to_end

keys['meta+left'] = buffer.word_left
keys['meta+right'] = buffer.word_right_end
keys['meta+shift+left'] = buffer.word_left_extend
keys['meta+shift+right'] = buffer.word_right_end_extend

keys['meta+shift+up'] = cursors.add_above
keys['meta+shift+down'] = cursors.add_below
keys['ctrl+meta+shift+up'] = cursors.add_to_start
keys['ctrl+meta+shift+down'] = cursors.add_to_end

keys['\b'] = buffer.delete_back
keys['meta+\b'] = deletion.delete_selection_or_word
keys['ctrl+\b'] = deletion.delete_selection_or_to_line_start

keys['\n'] = buffer.new_line
keys['shift+\n'] = buffer.new_line

-- The specification only covers tab in menus, in text it indents.
keys['\t'] = buffer.tab
keys['shift+\t'] = buffer.back_tab
