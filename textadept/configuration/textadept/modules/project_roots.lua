local find_repository_root = io.get_project_root

local function directory_of(path)
    if lfs.attributes(path, 'mode') == 'directory' then return path end
    return path:match('^(.+)/')
end

-- Textadept only recognises repositories whose .git is a directory,
-- but in a worktree .git is a file pointing to the repository.
-- Files outside any worktree, such as the commit messages of bare repositories,
-- use their own directory so that language servers start for them too.
function io.get_project_root(path, submodule)
    local root = find_repository_root(path, submodule) or find_repository_root(path, true)
    if root then return root end

    local file = type(path) == 'string' and path or buffer.filename or lfs.currentdir()
    return directory_of(file)
end
