local M = {}

-- Setup function for external configuration
M.opts = {
	fold_sign = { closed = "", open = "" },
	show_visual_line_highlight = true,
	gradual_line_hl = true,
}

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

	-- Set highlight groups
	vim.api.nvim_set_hl(0, "LineNr0", { fg = "#a6c7e0", bold = true }) -- current line
	vim.api.nvim_set_hl(0, "LineNr1", { fg = "#8da6b6" })
	vim.api.nvim_set_hl(0, "LineNr2", { fg = "#c9b18a" })
	vim.api.nvim_set_hl(0, "LineNr3", { fg = "#8c6a87" })
	vim.api.nvim_set_hl(0, "LineNr4", { fg = "#53546d" })
	vim.api.nvim_set_hl(0, "StatusColumnNumber", { link = "Constant" })

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "StatusColumnNumber", { link = "Constant" })
		end,
	})

	-- Set statuscolumn globally
	vim.o.statuscolumn = [[%!v:lua.require'statuscolumn'.statuscolumn()]]
end

-- Return signs from extmarks and regular signs
function M.get_signs(buf, lnum)
	local signs = {}
	local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, {
		details = true,
		type = "sign",
	})

	for _, ext in ipairs(extmarks) do
		local d = ext[4]
		table.insert(signs, {
			name = d.sign_name or "",
			text = d.sign_text,
			texthl = d.sign_hl_group,
			priority = d.priority,
		})
	end

	table.sort(signs, function(a, b)
		return (a.priority or 0) < (b.priority or 0)
	end)

	return signs
end

-- Return named marks
function M.get_mark(buf, lnum)
	local marks = vim.fn.getmarklist(buf)
	for _, mark in ipairs(marks) do
		if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
			return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
		end
	end
end

-- Format icon with padding and highlight
function M.icon(sign, len)
	sign = sign or {}
	len = len or 2
	local text = vim.fn.strcharpart(sign.text or "", 0, len)
	text = text .. string.rep(" ", len - vim.fn.strchars(text))
	return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

-- Get number of visual lines the wrapped line takes
local function get_num_wraps(lnum)
	return vim.api.nvim_win_call(0, function()
		local winwidth = vim.api.nvim_win_get_width(0)
		local line = vim.fn.getline(lnum)
		local width = vim.fn.strdisplaywidth(line)
		return math.floor(width / winwidth)
	end)
end

-- Get visual mode selection line range
function M.get_visual_range()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	return { start_line, end_line }
end

function M.statuscolumn()
	local win = vim.g.statusline_winid
	local buf = vim.api.nvim_win_get_buf(win)
	local is_file = vim.bo[buf].buftype == ""
	local show_signs = vim.wo[win].signcolumn ~= "no"

	local components = { "", "", "" } -- left, middle, right
	local signs = show_signs and M.get_signs(buf, vim.v.lnum) or {}

	local left_sign, right_sign
	for _, s in ipairs(signs) do
		if s.name:find("GitSign") or s.name:find("MiniDiffSign") then
			right_sign = s
		else
			left_sign = s
		end
	end

	components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left_sign)

	if vim.fn.foldclosed(vim.v.lnum) ~= -1 then
		components[3] = M.icon({ text = M.opts.fold_sign.closed, texthl = "Folded" })
	elseif vim.fn.foldlevel(vim.v.lnum) > 0 and vim.fn.foldclosed(vim.v.lnum) == -1 then
		components[3] = M.icon({ text = M.opts.fold_sign.open, texthl = "Folded" })
	elseif is_file and right_sign then
		components[3] = M.icon(right_sign)
	end

	local is_num = vim.wo[win].number
	local is_relnum = vim.wo[win].relativenumber
	local line_num_component = ""

	if vim.v.virtnum < 0 then
		line_num_component = "%=│ "
	elseif vim.v.virtnum > 0 then
		local num_wraps = get_num_wraps(vim.v.lnum)
		line_num_component = "%=" .. (vim.v.virtnum == num_wraps and "└ " or "├ ")
	elseif is_num or is_relnum then
		local mode = vim.fn.mode()
		if mode:match("[vV]") and M.opts.show_visual_line_highlight then
			local range = M.get_visual_range()
			if vim.v.lnum >= range[1] and vim.v.lnum <= range[2] then
				line_num_component = "%#StatusColumnNumber#"
			end
		elseif M.opts.gradual_line_hl then
			local rel = math.abs(vim.v.relnum)
			local hl = "LineNr" .. (rel <= 4 and rel or 4)
			line_num_component = "%#" .. hl .. "#"
		end

		local num_fmt = (vim.v.relnum == 0 and is_num) and "%l" or "%r"
		line_num_component = line_num_component .. num_fmt .. "%* "
	end

	components[2] = line_num_component
	return table.concat(components, "")
end

return M
