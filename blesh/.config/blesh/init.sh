#!/usr/bin/env bash

bind 'set completion-ignore-case on'

# Key Bindings
ble/widget/select-beginning-of-graphical-line() {
  ble/widget/set-mark
  ble/widget/beginning-of-graphical-line
}

ble/widget/select-end-of-graphical-line() {
  ble/widget/set-mark
  ble/widget/end-of-graphical-line
}

ble/widget/select-backward-uword() {
  ble/widget/set-mark
  ble/widget/backward-uword
}

ble/widget/select-forward-uword() {
  ble/widget/set-mark
  ble/widget/forward-uword
}

ble/widget/select-whole-graphical-line() {
  ble/widget/beginning-of-graphical-line
  ble/widget/set-mark
  ble/widget/end-of-graphical-line
}

ble/widget/delete-backward-graphical-line() {
  ble/widget/beginning-of-graphical-line
  ble/widget/delete-region-or
}

ble/widget/delete-forward-graphical-line() {
  ble/widget/end-of-graphical-line
  ble/widget/delete-region-or
}

ble-bind -f C-LEFT  beginning-of-graphical-line
ble-bind -f C-RIGHT end-of-graphical-line
ble-bind -f M-LEFT  backward-uword
ble-bind -f M-RIGHT forward-uword

ble-bind -f C-S-LEFT  select-beginning-of-graphical-line
ble-bind -f C-S-RIGHT select-end-of-graphical-line
ble-bind -f M-S-LEFT  select-backward-uword
ble-bind -f M-S-RIGHT select-forward-uword

ble-bind -f C-a select-whole-graphical-line
ble-bind -f C-d delete-forward-graphical-line
ble-bind -f C-k insert-comment

ble-bind -f C-BS delete-backward-graphical-line
ble-bind -f M-BS delete-backward-uword

# Graphics

# TODO: region="bg=$selection"
# TODO: region_target
# TODO: region_match
# TODO: region_insert
# TODO: disabled="fg=$disabled"
# TODO: syntax_command
# TODO: overwrite_mode
ble-face syntax_default=''
ble-face syntax_quoted='fg=green'
ble-face syntax_quotation='fg=green'
ble-face syntax_escape='fg=olive'
# operators
ble-face syntax_expr='fg=gray' # TODO: use unimportant
ble-face syntax_error='fg=red'
# TODO: syntax_varname
# shell operators
ble-face syntax_delimiter='fg=gray' # TODO: use unimportant
# braces in expansion
ble-face syntax_param_expansion='fg=gray' # TODO: use unimportant
# `!!`
ble-face syntax_history_expansion='fg=gray' # TODO: use unimportant
ble-face syntax_function_name='fg=cyan'
ble-face syntax_comment='fg=yellow'
ble-face syntax_glob='fg=gray' # TODO: use unimportant
ble-face syntax_brace='fg=gray' # TODO: use unimportant
ble-face syntax_tilde='fg=gray' # TODO: use unimportant
# TODO: syntax_document
# TODO: syntax_document_begin
ble-face command_builtin_dot='fg=olive'
ble-face command_builtin='fg=olive'
ble-face command_alias='fg=cyan'
ble-face command_function='fg=cyan'
ble-face command_file=''
ble-face command_file='' # TODO: use unimportant
ble-face command_keyword='fg=olive'
# TODO: command_jobs
ble-face command_directory=''
# TODO: command_directory
# TODO: command_suffix
# TODO: command_suffix_new
ble-face argument_option=''
ble-face argument_error='fg=red'
ble-face filename_directory=''
ble-face filename_directory_sticky='underline,fg=yellow'
ble-face filename_link='underline,fg=cyan'
ble-face filename_orphan='underline,fg=red'
ble-face filename_setuid='underline'
ble-face filename_setgid='underline'
ble-face filename_executable='underline,fg=cyan'
ble-face filename_other='underline'
ble-face filename_socket='underline,fg=yellow'
ble-face filename_pipe='underline,fg=yellow'
ble-face filename_character='underline,fg=yellow'
ble-face filename_block='underline,fg=yellow'
ble-face filename_warning='underline,fg=red'
ble-face filename_url='underline,fg=blue'
# TODO: filename_ls_colors
# TODO: varname_unset
# TODO: varname_export
# TODO: varname_array
# TODO: varname_hash
# TODO: varname_number
# TODO: varname_readonly
# TODO: varname_transform
ble-face varname_empty=''
ble-face varname_expr=''
ble-face varname_new=''

# Turn of command status info.
bleopt exec_elapsed_mark=
bleopt exec_errexit_mark=
bleopt exec_exit_mark=

# Sync history on every command.
bleopt history_share=true

:
