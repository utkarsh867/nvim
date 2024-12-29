local harpoon = require('harpoon')
local extensions = require("harpoon.extensions");

harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values

local function finder(harpoon_files)
  local harpoon_files = harpoon:list()
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end
  return require("telescope.finders").new_table({
    results = file_paths,
  })
end


local function detele_mark(prompt_buffnr)
  local harpoon_files = harpoon:list()
  local state = require("telescope.actions.state")
  local selected_entry = state.get_selected_entry()
  local current_picker = state.get_current_picker(prompt_buffnr)
  table.remove(harpoon_files.items, selected_entry.index)
  current_picker:refresh(finder())
end


local function toggle_telescope()
  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = finder(),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function (prompt_buffnr, map)
      map("i", "<C-d>", detele_mark)
      map("n", "<C-d>", detele_mark)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>hs", function() toggle_telescope() end)
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end)
