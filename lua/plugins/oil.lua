return {
	"stevearc/oil.nvim",
	enabled = false,
	opts = {
		view_options = {
			show_hidden = true,
		},
	},
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("oil").setup({})
		vim.keymap.set({ "n", "x" }, "<leader>e", function()
			require("oil").open()
		end, { silent = true })
	end,
}
