vim.loader.enable()


_G.Utils = require("extras")

require("config")
require("core.lazy")
require("core.lsp")
require("extras.statuscolumn")
require("extras.winbar")

vim.cmd("colorscheme rose-pine")
