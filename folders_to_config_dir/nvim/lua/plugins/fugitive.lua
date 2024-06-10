return {
  "tpope/vim-fugitive",
  enabled = false,
  cmd = { "G", "Git" },
  keys = {
    { "<leader>gb", ":Git branch<cr>", desc = "Git branch" },
    { "<leader>gbr", ":Git branch --remote<cr>", desc = "Git branch remote" },
    { "<leader>glog", ":Git log --oneline --graph --all<cr>", desc = "Git log" },
    { "<leader>gls", ":Git ls-files<cr>", desc = "Git list files" },
    { "<leader>gs", ":Git switch<cr>", desc = "Git switch" },
    { "<leader>gst", ":Git status<cr>", desc = "Git status" },
    { "<leader>wta", ":Git worktree add<cr>", desc = "Git worktree add" },
    { "<leader>wtl", ":Git worktree list<cr>", desc = "Git worktree list" },
    { "<leader>wtr", ":Git worktree remove<cr>", desc = "Git worktree remove" },
  },
}
