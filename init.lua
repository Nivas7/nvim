-- Add `t_RB` so that neovim detect background
-- https://github.com/neovim/neovim/issues/17070#issuecomment-1086775760
-- vim.loop.fs_write(2, '\27Ptmux;\27\27]11;?\7\27\\', -1, nil)

vim.g.cmp_enable = false
_G.Utils = require("utils")

-- https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
-- Global variables.
vim.g.projects_dir = vim.env.HOME .. "/dev/"
vim.g.personal_projects_dir = vim.g.projects_dir .. "/dev/Persona"
vim.g.work_projects_dir = vim.env.HOME .. "/Project"

-- if nvim was opened w/o argument, re-open the first oldfile that exist
vim.defer_fn(function()
	if vim.fn.argc() > 0 then
		return
	end
	for _, file in ipairs(vim.v.oldfiles) do
		if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= "COMMIT_EDITMSG" then
			vim.cmd.edit(file)
			return
		end
	end
end, 1)

require("core")

vim.filetype.add({
	extension = {
		http = "http",
	},
})
