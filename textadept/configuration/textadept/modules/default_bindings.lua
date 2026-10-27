-- Removes both textadept's and Scintilla's default key bindings,
-- so that only the bindings from the keybindings specification are used.

-- Fields of the keys module that are not key bindings.
local KEYS_MODULE_FIELDS = {
	KEYSYMS = true, keychain = true, assign_platform_bindings = true, CLEAR = true, mode = true
}

local MODIFIER_PREFIXES = {'ctrl+', 'meta+', 'shift+'}

local function clear_lexer_bindings(lexer_bindings)
	for key in pairs(lexer_bindings) do
		if key ~= '_lexer' then lexer_bindings[key] = nil end
	end
end

local function remove_textadept_binding(name, binding)
	local is_lexer_specific = type(binding) == 'table' and binding._lexer

	if is_lexer_specific then
		clear_lexer_bindings(binding)
	else
		keys[name] = nil
	end
end

local function remove_textadept_bindings()
	for name, binding in pairs(keys) do
		if not KEYS_MODULE_FIELDS[name] then remove_textadept_binding(name, binding) end
	end
end

local function remove_scintilla_bindings(target_view) target_view:clear_all_cmd_keys() end

local function without_modifiers(key)
	for _, prefix in ipairs(MODIFIER_PREFIXES) do
		if key:sub(1, #prefix) == prefix then key = key:sub(#prefix + 1) end
	end

	return key
end

local named_keys = {}
for _, name in pairs(keys.KEYSYMS) do named_keys[name] = true end

-- Without Scintilla's bindings, unbound keys like delete would insert their key code as text.
local function ignore_unbound_named_key(key)
	if named_keys[without_modifiers(key)] then return true end
end

remove_textadept_bindings()
events.connect(events.INITIALIZED, function()
	for _, existing_view in ipairs(_VIEWS) do remove_scintilla_bindings(existing_view) end
end)
events.connect(events.VIEW_NEW, function() remove_scintilla_bindings(view) end)
events.connect(events.KEYPRESS, ignore_unbound_named_key)
