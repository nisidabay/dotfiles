return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  config = true,
  keys = {
    {
      "tn",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Jump to next TODO",
    },
    {
      "tp",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Jump to prev TODO",
    },
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ft",
      "<cmd>TodoTelescope<cr>",
      { noremap = true, silent = true, desc = "Find todos" }
    ),
    vim.api.nvim_set_keymap(
      "n",
      "<leader>tl",
      "<cmd>TodoLocList<cr>",
      { noremap = true, silent = true, desc = "Show todos" }
    ),
  },
}
