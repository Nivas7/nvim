local M = {}
---@param bufnr integer
function M.get_lsp_format(bufnr)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    return filetype == "lua" and "prefer" or "fallback"
end

return M
