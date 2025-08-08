-- https://github.com/adibhanna/nvim

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local current_path = vim.env.PATH or ""

-- Remove any existing Mason bin entries to prevent duplicates
local path_entries = vim.split(current_path, ":")
local clean_path_entries = {}
local seen = {}

for _, entry in ipairs(path_entries) do
    -- Skip Mason bin entries and duplicates
    if entry ~= mason_bin and entry ~= "" and not seen[entry] then
        seen[entry] = true
        table.insert(clean_path_entries, entry)
    end
end

-- Add Mason bin directory at the beginning
local new_path = mason_bin .. ":" .. table.concat(clean_path_entries, ":")
vim.env.PATH = new_path

-- Verify Mason bin directory exists
if vim.fn.isdirectory(mason_bin) == 0 then
    -- Mason not installed yet, create placeholder
    vim.fn.mkdir(mason_bin, "p")
end
