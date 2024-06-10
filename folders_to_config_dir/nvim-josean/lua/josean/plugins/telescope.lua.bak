return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      telescope.load_extension("fzf"),
      telescope.load_extension("notify"),
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>bf", function()
      require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
    end, { desc = "Telescope file browser" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Show help files" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Show keymaps" })
    keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "Show notifications" })
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers<CR>",
      { noremap = true, silent = true, desc = "Show buffers" }
    )
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Show code diagnostics" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Execute commands" })
  end,
}
