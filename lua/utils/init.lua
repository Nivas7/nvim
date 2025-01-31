function reloadConfig()
	local config_path = vim.fn.stdpath("config") .. "/lua/"
	for name, _ in pairs(package.loaded) do
		if name:match("^" .. config_path:match("lua/(.*)$")) then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
