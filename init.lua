-- Add `t_RB` so that neovim detect background
-- https://github.com/neovim/neovim/issues/17070#issuecomment-1086775760
-- vim.loop.fs_write(2, '\27Ptmux;\27\27]11;?\7\27\\', -1, nil)

-- https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight
-- Global variables.
vim.g.projects_dir = vim.env.HOME .. "/dev/"
vim.g.personal_projects_dir = vim.g.projects_dir .. "/dev/Persona"
vim.g.work_projects_dir = vim.env.HOME .. "/Project"

-- if nvim was opened w/o argument, re-open the first oldfile that exist
require("core")

vim.filetype.add({
  extension = {
    http = "http",
  },
})
