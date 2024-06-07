-- ~/.config/nvim/lua/config/modules/snippets.lua
local M = {}

M.snippets_base_directory = vim.g.snippets_base_directory or vim.fn.stdpath("config") .. "/snippets"

function M.warn(message)
  vim.api.nvim_echo({ { message, "WarningMsg" } }, true, {})
end

function M.get_filetype()
  if vim.bo.filetype == "" then
    return vim.fn.input("Filetype: ")
  else
    return vim.bo.filetype
  end
end

function M.get_snippet_name(filetype)
  local snippet_name =
    vim.fn.input("Snippet: ", "", "customlist,v:lua.require'config.modules.snippets'.complete_snippet_names")
  return vim.fn.trim(snippet_name)
end

function M.get_snippet_files(filetype, prefix)
  return vim.fn.glob(M.snippets_base_directory .. "/" .. filetype .. "/" .. prefix .. "*", false, true)
end

function M.get_snippet_dirs(prefix)
  return vim.fn.glob(M.snippets_base_directory .. "/" .. prefix .. "*", false, true)
end

function M.get_snippet_names(filetype)
  local snippet_files = M.get_snippet_files(filetype, "")
  local snippet_names = vim.tbl_map(function(file)
    return vim.fn.fnamemodify(file, ":t:r")
  end, snippet_files)
  return snippet_names
end

function M.list_snippets()
  if not vim.fn.isdirectory(M.snippets_base_directory) then
    M.warn("No snippets directory found")
    return
  end
  local filetype = M.get_filetype()
  if filetype == "" then
    M.warn("No filetype entered")
    return
  end
  local snippet_files = M.get_snippet_files(filetype, "")
  if #snippet_files == 0 then
    M.warn("No snippets for filetype '" .. filetype .. "'")
    return
  end
  local snippet_names = vim.tbl_map(function(file)
    return vim.fn.fnamemodify(file, ":t:r")
  end, snippet_files)
  print(table.concat(snippet_names, "\n"))
end

function M.add_snippet()
  if not vim.fn.isdirectory(M.snippets_base_directory) then
    M.warn("No snippets directory found")
    return
  end
  local filetype = M.get_filetype()
  local filetype_dir = M.snippets_base_directory .. "/" .. filetype
  if not vim.fn.isdirectory(filetype_dir) then
    if vim.fn.confirm("Create filetype directory for '" .. filetype .. "'?", "&Yes\n&No") == 1 then
      vim.fn.mkdir(filetype_dir, "p")
    else
      M.warn("Directory for filetype '" .. filetype .. "' does not exist")
      return
    end
  end
  local name = M.get_snippet_name(filetype)
  if name == "" then
    M.warn("No snippet name entered")
    return
  end
  local filename = filetype_dir .. "/" .. name
  vim.fn.mkdir(vim.fn.fnamemodify(filename, ":h"), "p") -- Ensure the directory exists
  if vim.fn.filereadable(filename) == 1 then
    if not vim.fn.confirm("Overwrite current '" .. name .. "' snippet?", "&Yes\n&No") == 1 then
      return
    end
  end
  vim.fn.writefile(vim.fn.getline(1, "$"), filename)
  print("Snippet '" .. name .. "' added for filetype '" .. filetype .. "'")
end

function M.edit_snippet()
  if not vim.fn.isdirectory(M.snippets_base_directory) then
    M.warn("No snippets directory found")
    return
  end
  local filetype = M.get_filetype()
  if filetype == "" then
    M.warn("No filetype entered")
    return
  end
  local snippet_files = M.get_snippet_files(filetype, "")
  if #snippet_files == 0 then
    M.warn("No snippets for filetype '" .. filetype .. "'")
    return
  end
  local name = M.get_snippet_name(filetype)
  if name == "" then
    M.warn("No snippet name entered")
    return
  end
  local filename = M.snippets_base_directory .. "/" .. filetype .. "/" .. name
  if vim.fn.filereadable(filename) == 0 then
    M.warn("Snippet '" .. name .. "' does not exist")
    return
  end
  vim.cmd("tabedit " .. filename)
end

function M.delete_snippet()
  if not vim.fn.isdirectory(M.snippets_base_directory) then
    M.warn("No snippets directory found")
    return
  end
  local filetype = M.get_filetype()
  if filetype == "" then
    M.warn("No filetype entered")
    return
  end
  local snippet_files = M.get_snippet_files(filetype, "")
  if #snippet_files == 0 then
    M.warn("No snippets for filetype '" .. filetype .. "'")
    return
  end
  local name = M.get_snippet_name(filetype)
  if name == "" then
    M.warn("No snippet name entered")
    return
  end
  local filename = M.snippets_base_directory .. "/" .. filetype .. "/" .. name
  if vim.fn.filereadable(filename) == 0 then
    M.warn("Snippet '" .. name .. "' does not exist")
    return
  end
  if not vim.fn.confirm("Delete snippet '" .. name .. "'?", "&Yes\n&No") == 1 then
    return
  end
  vim.fn.delete(filename)
  print("Snippet '" .. name .. "' for filetype '" .. filetype .. "' deleted")
end

function M.insert_snippet()
  if not vim.fn.isdirectory(M.snippets_base_directory) then
    M.warn("No snippets directory found")
    return
  end
  local filetype = M.get_filetype()
  if filetype == "" then
    M.warn("No filetype entered")
    return
  end
  local snippet_files = M.get_snippet_files(filetype, "")
  if #snippet_files == 0 then
    M.warn("No snippets for filetype '" .. filetype .. "'")
    return
  end
  local name = M.get_snippet_name(filetype)
  if name == "" then
    M.warn("No snippet name entered")
    return
  end
  local filename = M.snippets_base_directory .. "/" .. filetype .. "/" .. name
  if vim.fn.filereadable(filename) == 0 then
    M.warn("Snippet '" .. name .. "' does not exist")
    return
  end
  local lines = vim.fn.readfile(filename)
  vim.api.nvim_put(lines, "l", true, true)
end

function M.complete_snippet_names(arg_lead, cmd_line, cursor_pos)
  local filetype = M.get_filetype()
  if filetype == "" then
    return {}
  end
  local snippet_names = M.get_snippet_names(filetype)
  return vim.tbl_filter(function(name)
    return string.match(name, "^" .. arg_lead)
  end, snippet_names)
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>ssl",
  ':lua require("config.modules.snippets").list_snippets()<CR>',
  { noremap = true, silent = true, desc = "List snippets" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ssa",
  ':lua require("config.modules.snippets").add_snippet()<CR>',
  { noremap = true, silent = true, desc = "Add snippet" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sse",
  ':lua require("config.modules.snippets").edit_snippet()<CR>',
  { noremap = true, silent = true, desc = "Edit snippet" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ssd",
  ':lua require("config.modules.snippets").delete_snippet()<CR>',
  { noremap = true, silent = true, desc = "Delete snippet" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ssi",
  ':lua require("config.modules.snippets").insert_snippet()<CR>',
  { noremap = true, silent = true, desc = "Insert snippet" }
)

vim.api.nvim_create_user_command("ListSnippets", function()
  M.list_snippets()
end, {})
vim.api.nvim_create_user_command("AddSnippet", function()
  M.add_snippet()
end, {})
vim.api.nvim_create_user_command("EditSnippet", function()
  M.edit_snippet()
end, {})
vim.api.nvim_create_user_command("DeleteSnippet", function()
  M.delete_snippet()
end, {
  nargs = 1,
  complete = function(arg_lead, cmd_line, cursor_pos)
    return M.complete_snippet_names(arg_lead, cmd_line, cursor_pos)
  end,
})
vim.api.nvim_create_user_command("InsertSnippet", function()
  M.insert_snippet()
end, {
  nargs = 1,
  complete = function(arg_lead, cmd_line, cursor_pos)
    return M.complete_snippet_names(arg_lead, cmd_line, cursor_pos)
  end,
})

return M
