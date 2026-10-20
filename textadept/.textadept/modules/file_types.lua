local GIT_MESSAGE_FILES = {'COMMIT_EDITMSG', 'MERGE_MSG', 'TAG_EDITMSG'}

for _, filename in ipairs(GIT_MESSAGE_FILES) do lexer.detect_extensions[filename] = 'git-commit' end
lexer.detect_extensions['git-rebase-todo'] = 'git-rebase'
