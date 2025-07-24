require("options")
require("keymaps")

require("statusline")
require("statuscolumn")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	spec = { import = "plugins" },
	ui = {
		border = "single",
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
})
