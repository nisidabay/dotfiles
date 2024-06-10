require("josean.core")
require("josean.lazy")

-- Load the snippets module
require("josean.modules.snippets")

-- Use nvim_exec to run Vimscript commands
local function set_highlight()
  vim.api.nvim_exec(
    [[
        highlight LineNr guifg=#FFFFFF guibg=#be2596 gui=bold
        highlight CursorLineNr guifg=#FFFFFF guibg=#FFC0CB gui=bold
    ]],
    false
  )
end

-- Call the function on Neovim startup
set_highlight()


-- highlight the comments
vim.api.nvim_set_hl(0, 'Comment', { fg = '#FFFFFF', bold = true })
