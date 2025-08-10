vim.loader.enable()

local colorscheme = "metal"

require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("core.lazy")
require("extras.statusline")
require("extras.statuscolumn")

-- theme
vim.cmd("colorscheme " .. colorscheme)
-- Transparency and colorcolumn
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight NonText guibg=none")
