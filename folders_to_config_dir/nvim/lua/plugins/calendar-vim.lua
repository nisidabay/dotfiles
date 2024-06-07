-- Calendar-vim Configuration
return {
  "mattn/calendar-vim",
  event = "VeryLazy",
  config = function()
    vim.g.calendar_diary = {
      {
        path = "~/vimwiki/diary",
      },
    }
  end,
}
