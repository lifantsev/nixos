-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile', 'flake.nix' }

local set_root = function()
    -- get the cwd either from current file or getcwd()
    local cwd = '';
    local cfile = vim.api.nvim_buf_get_name(0)

    if cfile == '' then
        cwd = vim.fn.getcwd()
    else
        cwd = vim.fs.dirname(cfile)
    end

    -- search upwards for root_names
    local root_file = vim.fs.find(root_names, { path = cwd, upward = true })[1]
    if root_file == nil then return end

    -- change to the directory we found
    root = vim.fs.dirname(root_file)
    vim.fn.chdir(root)
end

set_root()
