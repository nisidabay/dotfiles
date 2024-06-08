-- Configuration for the dasht Neovim plugin
return {
  "rizzatti/dash.vim",
  enabled = false,
  config = function()
    -- Enable dasht at startup
    vim.g.dasht_enable_at_startup = 1

    -- Map DashSearch to <leader>ds
    vim.keymap.set("n", "<leader>ds", "<Plug>DashSearch", { silent = true, desc = "Search for dash under cursor" })

    -- Map DashGlobalSearch to <leader>dg
    vim.keymap.set(
      "n",
      "<leader>dg",
      "<Plug>DashGlobalSearch",
      { silent = true, desc = "Search for dash under cursor in all docsets" }
    )
  end,
}
