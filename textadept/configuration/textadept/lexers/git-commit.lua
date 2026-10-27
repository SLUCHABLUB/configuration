-- Git commit message LPeg lexer.

local lexer = lexer
local P = lpeg.P

local lex = lexer.new(...)

-- Comments, such as git's instructions and status.
lex:add_rule('comment', lex:tag(lexer.COMMENT, lexer.to_eol(lexer.starts_line('#'))))

-- The diff that "git commit --verbose" adds below the message lasts until the end of the file.
local diff = lexer.load('diff')
local diff_start_rule = lex:tag(lexer.HEADING, lexer.to_eol(lexer.starts_line('diff --git')))
local never = P(false)
lex:embed(diff, diff_start_rule, never)

return lex
