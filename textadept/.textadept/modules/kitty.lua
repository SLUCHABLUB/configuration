-- Integration with the kitty terminal.
-- Setting the in_editor user variable lets kitty pass keys such as ctrl+v through (see kitty.conf).
-- Disambiguating keys lets textadept tell apart e.g. ctrl+backspace from ctrl+h.
-- Colour scheme reports let the theme follow kitty between light and dark.

local ESCAPE = '\27'
local BELL = '\7'

local BASE64_ONE = 'MQ=='

local SET_IN_EDITOR = ESCAPE .. ']1337;SetUserVar=in_editor=' .. BASE64_ONE .. BELL
local UNSET_IN_EDITOR = ESCAPE .. ']1337;SetUserVar=in_editor' .. BELL
local PUSH_DISAMBIGUATED_KEYS = ESCAPE .. '[>1u'
local POP_KEYBOARD_MODE = ESCAPE .. '[<u'
local ENABLE_COLOUR_SCHEME_REPORTS = ESCAPE .. '[?2031h'
local DISABLE_COLOUR_SCHEME_REPORTS = ESCAPE .. '[?2031l'
local REQUEST_COLOUR_SCHEME_REPORT = ESCAPE .. '[?996n'

-- A colour scheme report is "ESC [ ? 997 ; <scheme> n",
-- which textadept passes on as a CSI event with the leading and final bytes packed together.
local COLOUR_SCHEME_REPORT_COMMAND = string.byte('?') << 8 | string.byte('n')
local COLOUR_SCHEME_REPORT_ARGUMENT = 997
local THEMES_BY_SCHEME = {[1] = 'tilia-arrow-dark', [2] = 'tilia-arrow-light'}

local function write_to_terminal(sequence) io.stdout:write(sequence):flush() end

local function enter_kitty_mode()
	write_to_terminal(SET_IN_EDITOR)
	write_to_terminal(PUSH_DISAMBIGUATED_KEYS)
	write_to_terminal(ENABLE_COLOUR_SCHEME_REPORTS)
	write_to_terminal(REQUEST_COLOUR_SCHEME_REPORT)
end

local function leave_kitty_mode()
	write_to_terminal(DISABLE_COLOUR_SCHEME_REPORTS)
	write_to_terminal(POP_KEYBOARD_MODE)
	write_to_terminal(UNSET_IN_EDITOR)
end

local function set_theme(theme)
	for _, existing_view in ipairs(_VIEWS) do existing_view:set_theme(theme) end
end

local function follow_colour_scheme(command, arguments)
	local is_colour_scheme_report = command == COLOUR_SCHEME_REPORT_COMMAND and
		arguments[1] == COLOUR_SCHEME_REPORT_ARGUMENT
	if not is_colour_scheme_report then return end

	local theme = THEMES_BY_SCHEME[arguments[2]]
	if theme then set_theme(theme) end
end

-- Used until kitty has reported its colour scheme.
view:set_theme(THEMES_BY_SCHEME[1])

events.connect(events.INITIALIZED, enter_kitty_mode)
events.connect(events.RESUME, enter_kitty_mode)
events.connect(events.SUSPEND, leave_kitty_mode)
events.connect(events.QUIT, leave_kitty_mode)
events.connect(events.CSI, follow_colour_scheme)
