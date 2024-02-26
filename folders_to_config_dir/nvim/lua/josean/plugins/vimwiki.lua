-- Vimwiki Configuration
return {
  "vimwiki/vimwiki",
  event = "VeryLazy",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki",
        syntax = "markdown",
        ext = ".md",
      },
    }
    vim.g.vimwiki_ext2syntax = {
      [".md"] = "markdown",
      [".markdown"] = "markdown",
      [".mdown"] = "markdown",
    }
    vim.g.vimwiki_global_ext = 0 -- Don't treat all .md files as Vimwiki
    vim.g.vimwiki_markdown_link_ext = 1 -- Add markdown file extension when generating links
    -- Key Mappings
    vim.api.nvim_set_keymap("n", "<Leader>ww", ":VimwikiIndex<CR>", { noremap = true, silent = true })

    -- Change between formats
    function ToggleMarkdown()
      if vim.bo.filetype == "vimwiki" then
        vim.bo.filetype = "markdown"
      elseif vim.bo.filetype == "markdown" then
        vim.bo.filetype = "vimwiki"
      end
    end

    vim.api.nvim_set_keymap("n", "<silent> <C-N>", [[:lua ToggleMarkdown()<CR>]], { noremap = true, silent = true })
  end,
}
