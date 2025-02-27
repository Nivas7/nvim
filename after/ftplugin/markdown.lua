local bkeymap = require("utils.function").bufKeymap
local optl = vim.opt_local
--------------------------------------------------------------------------------

optl.expandtab = false
optl.tabstop = 4 -- less nesting in md
vim.bo.commentstring = "<--! %s -->" -- add spaces

-- so two trailing spaces highlighted, but not a single trailing space
optl.listchars:remove("trail")
optl.listchars:append({ multispace = "·" })

-- since markdown has rarely indented lines, and also rarely has overlong lines,
-- move everything a bit more to the right
if vim.bo.buftype == "" then
  optl.signcolumn = "yes:4"
end

--------------------------------------------------------------------------------

-- make bullets auto-continue (replaces bullets.vim)
-- INFO cannot set opt.comments permanently, since it disturbs the
-- correctly indented continuation of bullet lists when hitting opt.textwidth
optl.formatoptions:append("r") -- `<CR>` in insert mode
optl.formatoptions:append("o") -- `o` in normal mode

local function autocontinue(key)
  local comBefore = optl.comments:get()
	-- stylua: ignore
	optl.comments = {
		"b:- [ ]", "b:- [x]", "b:\t* [ ]", "b:\t* [x]", -- tasks
		"b:*", "b:-", "b:+", "b:\t*", "b:\t-", "b:\t+", -- unordered list
		"b:1.", "b:\t1.", -- ordered list
		"n:>", -- blockquotes
	}
  vim.defer_fn(function()
    optl.comments = comBefore
  end, 1) -- deferred to restore only after return
  return key
end

bkeymap("n", "o", function()
  return autocontinue("o")
end, { expr = true })
bkeymap("i", "<CR>", function()
  return autocontinue("<CR>")
end, { expr = true })

--------------------------------------------------------------------------------
-- HEADINGS

-- Jump to next/prev heading (`##` to skip level 1 and comments in code-blocks)
bkeymap("n", "<C-j>", [[/^##\+ .*<CR>]], { desc = " Next heading" })
bkeymap("n", "<C-k>", [[?^##\+ .*<CR>]], { desc = " Prev heading" })

---@param dir 1|-1
local function headingsIncremantor(dir)
  local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
  local curLine = vim.api.nvim_get_current_line()

  local updated = curLine:gsub("^#* ", function(match)
    if dir == -1 and match ~= "# " then
      return match:sub(2)
    end
    if dir == 1 and match ~= "###### " then
      return "#" .. match
    end
    return ""
  end)
  if updated == curLine then
    updated = (dir == 1 and "## " or "###### ") .. curLine
  end

  vim.api.nvim_set_current_line(updated)
  local diff = #updated - #curLine
  vim.api.nvim_win_set_cursor(0, { lnum, col + diff })
end

-- <D-h> remapped to <D-ö>, PENDING https://github.com/neovide/neovide/issues/2558
bkeymap("n", "<C-i>", function()
  headingsIncremantor(1)
end, { desc = " Increment heading" })
bkeymap("n", "<C-H>", function()
  headingsIncremantor(-1)
end, { desc = " Decrement heading" })

--------------------------------------------------------------------------------
-- MARKDOWN-SPECIFIC KEYMAPS

-- Tasks
bkeymap("n", "<leader>x", "mzI- [ ] <Esc>`z", { desc = " Add Task" })

-- Format Table
bkeymap("n", "<leader>ft", "vip:!pandoc --to=gfm<CR>", { desc = " Format table under cursor" })

-- cmd+u: markdown bullet
bkeymap("n", "<C-u>", "mzI- <Esc>`z", { desc = "• Bullet list" })

-- cmd+k: markdown link
bkeymap("n", "<C-k>", "bi[<Esc>ea]()<Esc>hp", { desc = " Link" })
bkeymap("x", "<C-k>", "<Esc>`<i[<Esc>`>la]()<Esc>hp", { desc = " Link" })
bkeymap("i", "<C-k>", "[]()<Left><Left><Left>", { desc = " Link" })

-- cmd+b: bold
bkeymap("n", "<C-b>", "bi**<Esc>ea**<Esc>", { desc = " Bold" })
bkeymap("i", "<C-b>", "****<Left><Left>", { desc = " Bold" })
bkeymap("x", "<C-b>", "<Esc>`<i**<Esc>`>lla**<Esc>", { desc = " Bold" })

-- cmd+i: italics
bkeymap("n", "<C-i>", "bi*<Esc>ea*<Esc>", { desc = " Italics" })
bkeymap("i", "<C-i>", "**<Left>", { desc = " Italics" })
bkeymap("x", "<C-i>", "<Esc>`<i*<Esc>`>la*<Esc>", { desc = " Italics" })

--------------------------------------------------------------------------------

-- MARKDOWN PREVIEW (simplified version of markdown-preview.nvim)
bkeymap("n", "<leader>er", function()
  local outputPath = "/tmp/markdown-preview.html"
  local css = vim.fn.stdpath("config") .. "/after/ftplugin/github-markdown.css"

  -- create github-html via pandoc
  vim.cmd("silent update")
  vim
    .system({
      "pandoc",
      -- rebasing paths, so images are available at output location
      "--from=gfm+rebase_relative_paths",
      vim.api.nvim_buf_get_name(0),
      "--output=" .. outputPath,
      "--standalone",
      "--css=" .. css,
    })
    :wait()

  local uri = "file://" .. outputPath
  vim.ui.open(uri)
end, { desc = " Preview" })
