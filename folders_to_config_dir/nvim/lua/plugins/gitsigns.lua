return {
  "lewis6991/gitsigns.nvim", -- Plugin name
  event = { "VeryLazy" }, -- Events to trigger on
  opts = {
    signs = {
      add = { hl = "GitSignsAdd", text = "+" },
      change = { hl = "GitSignsChange", text = "~" },
      delete = { hl = "GitSignsDelete", text = "-" },
      topdelete = { hl = "GitSignsDelete", text = "_" },
      changedelete = { hl = "GitSignsChange", text = "~" },
    },
  },
}
