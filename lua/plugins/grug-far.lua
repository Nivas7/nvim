-- NOTE: Find And Replace
return {
  "MagicDuck/grug-far.nvim",
  event = "VeryLazy",
  cmd = "GrugFar",
  init = function()
    vim.keymap.set("n", "<leader>fR", "<cmd>GrugFar<cr>", { desc = "GrugFar | Find And Replace", silent = true })
  end,
  opts = {},
}
