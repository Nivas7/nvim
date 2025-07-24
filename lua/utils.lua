local M = {}

function M.tree()
	local node = vim.treesitter.get_node()
	if not node then
		print("No node found at cursor")
		return
	end

	local i = 0
	local max_depth = 10

	-- Traverse up to find the "code" node or stop after max_depth
	while node and node:type() ~= "code" and i < max_depth do
		node = node:parent()
		i = i + 1
	end

	if not node or node:type() ~= "code" then
		print("No 'code' node found within depth limit")
		return
	end

	local start_row, start_col, end_row, end_col = node:range()

	-- Start visual mode selection from start to end of the node
	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col + 1 }) -- move to start
	vim.cmd("normal! v") -- start visual mode
	vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col }) -- extend selection to end
end

return M
