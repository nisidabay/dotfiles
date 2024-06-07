-- Configuration for the harpoon Neovim plugin.
return {
  "ThePrimeagen/harpoon", -- Plugin name and repository
  dependencies = {
    "nvim-lua/plenary.nvim", -- Plugin dependencies
    event = "VeryLazy",
  },
  config = function()
    -- Set keymaps using the vim.keymap function for conciseness.
    local keymap = vim.keymap

    -- Keymap for marking files with harpoon.
    keymap.set(
      "n",
      "<leader>hm",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      { desc = "Mark file with harpoon" }
    )

    -- Keymap for showing the harpoon menu.
    keymap.set(
      "n",
      "<leader>hq",
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      { desc = "Show harpoon menu" }
    )

    -- Keymap for navigating to the next harpoon mark.
    keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })

    -- Keymap for navigating to the previous harpoon mark.
    keymap.set(
      "n",
      "<leader>hp",
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      { desc = "Go to previous harpoon mark" }
    )
  end,
}
