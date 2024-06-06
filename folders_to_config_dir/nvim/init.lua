require("nisidabay.core")
require("nisidabay.lazy")

-- Load the snippets module
require("nisidabay.modules.snippets")

-- Function to highlight line numbers and cursor line
local function set_highlight()
  vim.api.nvim_exec2(
    [[
        highlight LineNr guifg=#FFFFFF guibg=#be2596 gui=bold
        highlight CursorLineNr guifg=#FFFFFF guibg=#FFC0CB gui=bold
    ]],
    {}
  )
end

-- Call the function on Neovim startup
set_highlight()

-- highlight the comments
vim.api.nvim_set_hl(0, "Comment", { fg = "#FFFFFF", bold = true })
