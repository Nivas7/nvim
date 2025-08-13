vim.loader.enable()

local colorscheme = "rose-pine"


require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("core.lazy")
require("extras.statusline")
require("extras.statuscolumn")


-- theme
vim.cmd("colorscheme " .. colorscheme)
