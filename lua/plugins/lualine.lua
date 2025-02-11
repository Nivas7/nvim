return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = "auto",
				component_separators = "",
				section_separators = "",
			},
		})
	end,
}
