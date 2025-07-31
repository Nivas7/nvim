local statusline = {}
_G.statusline = statusline

local api = vim.api
local fn = vim.fn
local bo = vim.bo
local diagnostic = vim.diagnostic
local lsp = vim.lsp

statusline.highlight_definitions = {}

--- Define or update a highlight group
---@param name string
---@param hl_or_color string
---@param color_type? "bg"|"fg"
---@param bold? boolean
---@return string
function statusline.define_highlight(name, hl_or_color, color_type, bold)
	local hl_name = "Statusline" .. name
	statusline.highlight_definitions[hl_name] = {
		name = name,
		hl_or_color = hl_or_color,
		color_type = color_type,
		bold = bold,
	}
	statusline.create_or_update_hl(hl_name, statusline.highlight_definitions[hl_name])
	return hl_name
end

--- Create or update a highlight group
---@param hl_name string
---@param def table
function statusline.create_or_update_hl(hl_name, def)
	local normal_hl = api.nvim_get_hl(0, { name = "Normal", link = false }) or {}
	local base_hl = api.nvim_get_hl(0, { name = "StatusLine", link = false }) or {}

	local fg_color

	if def.hl_or_color:sub(1, 1) == "#" then
		fg_color = def.hl_or_color
	else
		local src_hl = api.nvim_get_hl(0, { name = def.hl_or_color, link = false }) or {}
		if src_hl.link then
			src_hl = api.nvim_get_hl(0, { name = src_hl.link, link = false }) or {}
		end

		local key = def.color_type == "bg" and "bg" or "fg"
		local fallback = normal_hl[key] or 0xFFFFFF -- default white if not found

		if src_hl[key] then
			fg_color = string.format("#%06x", src_hl[key])
		else
			fg_color = string.format("#%06x", fallback)
		end
	end

	local bg_color = base_hl.bg or normal_hl.bg or 0x000000
	if type(bg_color) == "number" then
		bg_color = string.format("#%06x", bg_color)
	end

	api.nvim_set_hl(0, hl_name, {
		fg = fg_color,
		bg = bg_color,
		bold = def.bold or false,
	})
end

function statusline.reload_highlights()
	for hl_name, def in pairs(statusline.highlight_definitions) do
		statusline.create_or_update_hl(hl_name, def)
	end
end

function statusline.init()
	api.nvim_create_autocmd("ColorScheme", {
		group = api.nvim_create_augroup("StatuslineHighlightReload", { clear = true }),
		callback = statusline.reload_highlights,
	})
end

local function highlight_segment(hl, text)
	return string.format("%%#%s#%s", hl, text)
end

local function get_mode()
	local mode_map = {
		n = "NO",
		v = "VI",
		V = "VL",
		["\22"] = "VB",
		i = "IN",
		R = "RE",
		c = "CO",
		t = "TE",
	}
	local mode = api.nvim_get_mode().mode
	return highlight_segment("Statusline", " " .. (mode_map[mode] or mode))
end

local function get_cwd()
	---@diagnostic disable-next-line: undefined-field
	return highlight_segment("StatusLinePath", " " .. fn.fnamemodify(vim.uv.cwd(), ":t"))
end

local function get_filename()
	if bo.filetype == "intro" then
		return ""
	end
	local file = fn.expand("%:p")
	---@diagnostic disable-next-line: undefined-field
	local cwd = vim.uv.cwd()
	local modified = bo.modified and "  " or ""
	local relative = file:gsub(cwd .. "/", "")

	local parts = vim.split(relative, "/")
	if #parts > 3 then
		relative = ".../" .. table.concat(vim.list_slice(parts, #parts - 2), "/")
	end

	local ok, icons = pcall(require, "mini.icons")
	local result = { (ok and icons.get("file", file)) or "", "", true }
	local icon, hl, is_default = unpack(result)
	hl = statusline.define_highlight("FileIcon", tostring(hl or ""))
	icon = is_default and "" or icon

	return table.concat({
		highlight_segment(hl, icon),
		highlight_segment("StatusLine", " " .. relative),
		highlight_segment(statusline.define_highlight("Modified", "Substitute", "bg", true), modified),
	})
end

local function get_git_status()
	local summary = vim.b.minidiff_summary
	local branch = vim.b.git_branch or ""
	if not summary then
		return highlight_segment("StatusLineGitBranch", branch .. " ")
	end

	local result = { highlight_segment("StatusLineGitBranch", branch) }
	local function add_part(hl, symbol, val)
		if val and val > 0 then
			table.insert(
				result,
				highlight_segment(statusline.define_highlight(hl, "MiniDiffSign" .. hl), symbol .. val)
			)
		end
	end

	add_part("Add", "+", summary.add)
	add_part("Change", "~", summary.change)
	add_part("Delete", "-", summary.delete)
	return table.concat(result, " ")
end

local function get_diagnostics()
	if not diagnostic.is_enabled() then
		return ""
	end
	local count = { 0, 0, 0, 0 }
	for _, d in ipairs(diagnostic.get(0)) do
		count[d.severity] = count[d.severity] + 1
	end

	local sev_map = { "Error", "Warn", "Info", "Hint" }
	local out = {}
	for i, sev in ipairs(sev_map) do
		if count[i] > 0 then
			local ok, icons = pcall(require, "mini.icons")
			local result = ok and { icons.get("lsp", sev) } or { "", sev }
			local icon, hl = unpack(result)
			table.insert(out, highlight_segment(statusline.define_highlight(sev, hl), icon .. count[i]))
		end
	end
	return table.concat(out, " ")
end

local function get_lsp_status()
	for _, client in ipairs(lsp.get_clients()) do
		if vim.tbl_contains(client.config.filetypes or {}, bo.filetype) then
			return highlight_segment("StatusLineLSP", "[" .. client.name .. "]")
		end
	end
	return ""
end

local function get_line_info()
	local col, line, total = fn.col("."), fn.line("."), fn.line("$")
	local chars = { "▔", "🮂", "🮃", "🮑", "🮒", "▃", "▂", "▁" }
	local idx = math.floor((line - 1) / total * #chars) + 1
	local bar = chars[idx]:rep(2)
	local hl = statusline.define_highlight("Scrollbar", "Substitute", "bg", true)
	return string.format(" %%#StatusLinePosition#%02d/%d %%#%s#%s", col, total, hl, bar)
end

function statusline.active()
	return table.concat({
		get_mode(),
		get_cwd(),
		get_git_status(),
		" %<",
		"%=",
		get_filename(),
		"%<",
		"%=",
		get_diagnostics(),
		get_lsp_status(),
		get_line_info(),
	})
end

vim.o.statusline = "%!v:lua.statusline.active()"
return statusline
