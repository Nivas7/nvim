--@module Snacks
-- Open tmux sidebar and run the npm scripts
local function get_npm_scripts()
  local file = io.open("package.json", "r")
  if file then
    local content = file:read("*a")
    file:close()
    local packageData = vim.json.decode(content)
    if packageData.scripts then
      local scripts = {}
      for key, value in pairs(packageData.scripts) do
        -- add key, value to the scripts table
        scripts[key] = value
      end
      return scripts
    else
      return "No scripts found in package.json"
    end
  else
    return "package.json file not found"
  end
end

-- Open custom picker
function RunNpmInSidebar()
  local scripts = get_npm_scripts()
  -- if scripts is a string then print it and exit
  if type(scripts) == "string" then
    print(scripts)
    return
  end

  return Snacks.picker({
    finder = function()
      local items = {}
      for key, value in pairs(scripts) do
        table.insert(items, {
          key = value,
          text = key,
        })
      end
      -- sort the items table by the key
      table.sort(items, function(a, b)
        return a.key < b.key
      end)
      return items
    end,
    layout = {
      layout = {
        box = "horizontal",
        width = 0.5,
        height = 0.5,
        {
          box = "vertical",
          border = "rounded",
          title = "NPM Scripts",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
      },
    },
    format = function(item, _)
      local ret = {}
      local a = Snacks.picker.util.align
      ret[#ret + 1] = { a(item.key, 20) }
      ret[#ret + 1] = { " " }
      ret[#ret + 1] = { a(item.text, 20) }

      return ret
    end,
    confirm = function(picker, item)
      picker:close()
      os.execute("tmux-split-right 'npm run " .. item.text .. "'")
    end,
  })
end

vim.keymap.set("n", "<leader>sns", function()
  RunNpmInSidebar()
end, { silent = true, desc = "[S]plit [N]ew [S]idebar" })

print("loaded functions")
