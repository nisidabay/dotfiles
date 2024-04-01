-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

--- General Keymaps
keymap.set("n", "<leader>mv", ":tabnew  $NEOVIM<CR>", { desc = "Open nvim config" })
keymap.set("n", "<leader>rv", ":source  $NEOVIM<CR>", { desc = "Reload nvim config" })

keymap.set({ "i", "c" }, "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set({ "i", "c" }, "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "x", '"_x', { desc = "Delete character without copying into register" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize windows
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Resize window left" })
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize window right" })

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set(
  "n",
  "<leader>tb",
  '<cmd>tabnew<CR><cmd>setlocal buftype=nofile bufhidden=hide noswapfile<CR><cmd>echo "Scratch Buffer"<CR>',
  { silent = true, desc = "Open a new scratch buffer in a tab" }
)

-- Clipboard management
keymap.set("n", "<F4>", ":r !xclip -o -sel clip<CR>", { silent = true, desc = "Paste from clipboard" })
keymap.set("x", "<F6>", ":w !xclip -i -sel clip<CR><CR>", { silent = true, desc = "Copy to clipboard" })

-- File workding dir
-- Change the working directory to the directory of the current file
function Change_cwd_to_current_file_dir()
  local current_dir = vim.fn.expand("%:p:h")
  vim.cmd("lcd " .. current_dir)
  print("Changed directory to: " .. current_dir)
end

keymap.set(
  "n",
  "<leader>.",
  [[:lua Change_cwd_to_current_file_dir()<CR>]],
  { silent = true, desc = "Change_cwd_to_current_file_dir" }
)

-- Text surrounding and markdown
keymap.set(
  "x",
  "<leader>vc",
  [[:s/\%V\(^.*$\)/`&`/g<CR>gv]],
  { silent = true, desc = "Surround selected text with quotes" }
)

keymap.set("n", "<leader>qwa", 'Bi"<Esc>Ea"<Esc>', { silent = true, desc = "Surround word with quotes" })

keymap.set("n", "<leader>qwc", "Bi`<Esc>Ea`<Esc>", { silent = true, desc = "Surround word code" })

keymap.set("n", "<leader>qwb", "Bi**<Esc>Ea**<Esc>", { silent = true, desc = "Surround word in bold " })

keymap.set("n", "<leader>qws", "Bi*<Esc>Ea*<Esc>", { silent = true, desc = "Surround word italics" })

keymap.set("n", "<leader>qwi", "Bi$<Esc>Ea$<Esc>", { silent = true, desc = "Surround inline code" })

-- Lines surrounding and markdown
keymap.set("n", "<leader>qla", 'I"<Esc>$A"<Esc>', { silent = true, desc = "Surround line with quotes" })

keymap.set("n", "<leader>qlc", "I`<Esc>$A`<Esc>", { silent = true, desc = "Surround line with code" })

keymap.set("n", "<leader>qlb", "I**<Esc>$A**<Esc>", { silent = true, desc = "Surround line in bold" })

keymap.set("n", "<leader>qls", "I*<Esc>$A*<Esc>", { silent = true, desc = "Surround line with italics" })

keymap.set("n", "<leader>qli", "I$<Esc>$A$<Esc>", { silent = true, desc = "Surround line with code" })

-- Move between windows
keymap.set("n", "<leader>mwr", "<C-W><C-L>", { desc = "Move right" })
keymap.set("n", "<leader>mwl", "<C-W><C-H>", { desc = "Move left" })
keymap.set("n", "<leader>mwd", "<C-W><C-J>", { desc = "Move1 down" })
keymap.set("n", "<leader>mwu", "<C-W><C-K>", { desc = "Move1 up" })

-- Visual line movement
keymap.set("x", "J", ":m'>+1<CR>gv=gv", { desc = "Visual move line below" })
keymap.set("x", "K", ":m'<-2<CR>gv=gv", { desc = "Visual move line up" })

-- Outdent selected text
keymap.set("x", "<", "<gv", { desc = "Outdent selected text" })
keymap.set("x", ">", ">gv", { desc = "Indent selected text" })

-- Which bash
keymap.set("n", "<leader>wb", ":read !which bash<CR>I#!<Esc>", { silent = true, desc = "Insert bash shebang" })

-- Which python3
keymap.set("n", "<leader>wp", ":read !which python3<CR>I#!<Esc>", { silent = true, desc = "Insert python3 shebang" })

-- Which ruby
keymap.set("n", "<leader>wrb", ":read !which ruby<CR>I#!<Esc>", { silent = true, desc = "Insert ruby shebang" })

-- Which lua
keymap.set("n", "<leader>wl", ":read !which lua<CR>I#!<Esc>", { silent = true, desc = "Insert lua shebang" })

-- Append date
keymap.set("n", "<leader>ad", ":read !date<CR>I# Date: <Esc>", { silent = true, desc = "Append date" })

-- Underline word
keymap.set("n", "<leader>0", "yyp<c-v>$r=A<CR><Esc>", { silent = true, desc = "Underline word with =" })

-- Insert 79 #
keymap.set("n", "<leader>7", "i#<esc>79a#<esc>", { silent = true, desc = "Insert # separators" })

-- Insert word in a box
keymap.set("n", "<leader>8", "yyp<c-v>$r-A<esc>yy1kP<esc>", { silent = true, desc = "Surround word in a box" })

-- Underline word
keymap.set("n", "<leader>9", "yyp<c-v>$r-A<CR><Esc>", { silent = true, desc = "Underline a word with _" })
keymap.set("i", "<leader>9", "<Esc>yyp<c-v>$r-A<CR>", { desc = "Underline a word with _" })

-- Compile current file
keymap.set(
  "n",
  "<leader>gc",
  ":!gcc -Wall -Wextra -g -std=c11 -o %:r %<CR>",
  { silent = true, desc = "Compile C code" }
)
keymap.set(
  "n",
  "<leader>gcn",
  ":!gcc -Wall -Wextra -g -std=c11 -o %:r -lncurses %<CR>",
  { silent = true, desc = "Compile ncurses C code" }
)

keymap.set("n", "<leader>rp", ":!python3 %<CR>", { silent = true, desc = "Run python3 code" })

-- Run lua code
keymap.set("n", "<leader>rl", ":!lua %<CR>", { silent = true, desc = "Run lua code" })

-- Run bash code
keymap.set("n", "<leader>rb", ":!bash %<CR>", { silent = true, desc = "Run ruby code" })

-- Run go code
keymap.set("n", "<leader>gl", ":!go run %<CR>", { silent = true, desc = "Run go code" })
keymap.set("n", "<leader>gb", ":!go build %<CR>", { silent = true, desc = "Build go code" })

-- Make file executable
keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true, desc = "Make current buffer executable" })

-- Comment line in Python and Bash
keymap.set("x", "<leader>c", ":normal I#<CR><Esc>", { desc = "Comment line in python3" })

-- Uncomment line
keymap.set("x", "<leader>u", ":normal ^x <CR><Esc>", { desc = "Uncomment line in python3" })

-- Save selected chunk in vmode
keymap.set("x", "<leader>s", ':w <C-R>=input("Save to file: ")<CR><Esc>', { desc = "Save selected chunk" })

-- Spelling
keymap.set("n", "<F2>", ":setlocal spell spelllang=es_es<CR>", { silent = true, desc = "Spanish spelling" })
keymap.set("n", "<F3>", ":setlocal spell spelllang=en_us<CR>", { silent = true, desc = "English spelling" })

-- X11 Clipboard
-- Paste from clipboard
keymap.set("n", "<F4>", ":r !xclip -o -sel clip<CR><Esc>", { noremap = true })
-- Copy to Clipboard
keymap.set("x", "<F6>", ":w !xclip -i -sel clip<CR><CR>", { silent = true })

-- Wayland Clipboard

-- Paste from clipboard
keymap.set("n", "<C-i>", ":r !wl-paste<CR><Esc>", { noremap = true })
-- Copy to clipboard
keymap.set("x", "<C-c>", ":w !wl-copy<CR><CR>", { silent = true })

-- Buffers
keymap.set(
  "n",
  "<leader>b",
  [[:set nomore <Bar> :ls <Bar> :set more <CR>:b<leader>]],
  { silent = true, desc = "Show buffers" }
)

keymap.set(
  "n",
  "<leader>ws",
  ':w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<CR>',
  { silent = true, desc = "Save buffer as sudo" }
)
keymap.set(
  "n",
  "<leader>cab",
  [[:update <bar> %bd <bar> e# <bar> bd# <CR><CR>]],
  { silent = true, desc = "Close all buffers but this one" }
)
keymap.set("n", "<leader>vab", ":bufdo vsp<CR>", { silent = true, desc = "Show buffers vertically" })

-- Vimwiki
keymap.set("n", "<leader>ww", ":VimwikiIndex<CR>", { silent = true, desc = "VimwikiIndex" })
keymap.set("n", "<leader>rw", ":VimwikiRenameFile<ESC>", { silent = true, desc = "VimwikiRenameFile" })
keymap.set("n", "<leader>di", ":VimwikiDiaryIndex<CR>", { silent = true, desc = "VimwikiDiaryIndex" })
keymap.set("n", "<leader>kal", ":Calendar<CR>", { silent = true, desc = "Calendar" })

keymap.set("n", "gx", ":!xdg-open <cfile><CR>", { silent = true, desc = "Open Link" })
keymap.set("v", "gx", ":!xdg-open <cfile><CR>", { silent = true, desc = "Open Link" })

-- Edit Configuration
keymap.set("n", "<leader>ek", ":edit ~/.config/nvim/lua/josean/core/keymaps.lua<CR>", { desc = "Edit keymaps" })

keymap.set("n", "<leader>eo", ":edit ~/.config/nvim/lua/josean/core/options.lua<CR>", { desc = "Edit options" })

keymap.set("n", "<leader>rc", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload Config" })
