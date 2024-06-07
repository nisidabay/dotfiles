-- This plugin provides the following mappings which allow you to move between
-- Vim panes and tmux splits seamlessly.

--  `<ctrl-h>` => Left
--  `<ctrl-j>` => Down
--  `<ctrl-k>` => Up
--  `<ctrl-l>` => Right
--  `<ctrl-\>` => Previous split

return {
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  event = "VeryLazy",
  config = function()
    -- Write all buffers before navigating from Vim to tmux pane
    vim.g.tmux_navigator_save_on_switch = 2
    -- Disable wrapping
    vim.g.tmux_navigator_no_wrap = 1
  end,
}
