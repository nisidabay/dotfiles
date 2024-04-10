
"------------------------------------------------------------------------------
" Vundle configuration 
"------------------------------------------------------------------------------ 
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"
call vundle#begin()
"------------------------------------------------------------------------------
" Vundle is short for Vim bundle and is a Vim plugin manager.
Plugin 'VundleVim/Vundle.vim'

"------------------------------------------------------------------------------
" Syntastic is a syntax checking plugin for Vim. It runs files through external 
" syntax checkers and displays any resulting errors to the user.
"Plugin 'vim-syntastic/syntastic'

"------------------------------------------------------------------------------
" Syntax highlight for kotlin
Plugin 'udalov/kotlin-vim'
" Language Server
Plugin 'fwcd/kotlin-language-server'

"------------------------------------------------------------------------------
" Maktaba is a vimscript plugin library. It is designed for plugin authors.
Plugin 'google/vim-maktaba'

"------------------------------------------------------------------------------
" codefmt is a utility for syntax-aware code formatting. It contains several 
" built-in formatters, and allows new formatters to be registered by other plugins.
Plugin 'google/vim-codefmt'

"------------------------------------------------------------------------------
" Glaive is a utility for configuring maktaba plugins.
Plugin 'google/vim-glaive'

"------------------------------------------------------------------------------
" Saves and restores the state of the NERDTree between sessions.
Plugin 'scrooloose/nerdtree'

"------------------------------------------------------------------------------
" A nice statusline at the bottom of each vim window.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"------------------------------------------------------------------------------
" A light and configurable statusline/tabline plugin for Vim.
Plugin 'itchyny/lightline.vim' " Enable for rosepine theme"
"------------------------------------------------------------------------------
" This plug-in provides automatic closing of quotes, parenthesis, brackets, etc.
Plugin 'Raimondi/delimitMate'

"------------------------------------------------------------------------------
"Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
"Plugin 'ctrlpvim/ctrlp.vim'

"------------------------------------------------------------------------------
" Tagbar is a Vim plugin that provides an easy way to browse the tags of the 
" current file and get an overview of its structure.
Plugin 'majutsushi/tagbar'

"------------------------------------------------------------------------------
" This plugin is used for displaying thin vertical lines at each indentation level 
" for code indented with spaces.
Plugin 'Yggdroot/indentLine'

"------------------------------------------------------------------------------
" When you open a markdown file in Vim, a browser window will open which shows the 
" compiled markdown in real-time, and closes once you close the file in Vim.
Plugin 'instant-markdown/vim-instant-markdown'

"------------------------------------------------------------------------------
" Creates a calendar window you can use within vim.
Plugin 'mattn/calendar-vim'

"------------------------------------------------------------------------------
" This is a vim plugin that provides rust file detection, syntax highlighting, 
" formatting, syntastic integration, and more. It requires vim 8 or higher for 
" full functionality. Some things may not work on earlier versions.
Plugin 'rust-lang/rust.vim'
" Install rustfmt
" rustup component add rustfmt
"------------------------------------------------------------------------------
" Highlights Haskell code in GitHub Flavored Markdown, and Literate Haskell
" documents as Markdown.3
"Plugin 'dag/vim2hs'

"------------------------------------------------------------------------------
" C Syntax Highlighting Extension for Vim.
Plugin 'https://github.com/NLKNguyen/c-syntax.vim'

"------------------------------------------------------------------------------
"This s plugin highlights code by indentation level instead of language syntax.
"It is specially useful when dealing with deeply nested code or callback hells.
:"Plugin 'thiagoalessio/rainbow_levels.vim'

" Creating a mapping to turn it on and off:
"map <leader>l :RainbowLevelsToggle<cr>

" Or automatically turning it on for certain file types:
"autocmd Filetype * if index(['shell', 'python', 'c', 'xml', 'yaml'], &ft) | call rainbow_levels#on() | else | call rainbow_levels#off() | endif

"------------------------------------------------------------------------------ 
" Easy note taking in Vim
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-notes'

"------------------------------------------------------------------------------ 
"vim-signature
"Pluging to navigate marks
Plugin 'kshenoy/vim-signature'

"------------------------------------------------------------------------------ 
" gruvbox colorscheme
"Plugin 'morhetz/gruvbox'


"Plugin for formatting code
"------------------------------------------------------------------------------ 
Plugin 'vim-autoformat/vim-autoformat'

"Plugin for navigating between vim and tmux panes
"------------------------------------------------------------------------------ 
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'rose-pine/vim'
call vundle#end()
"------------------------------------------------------------------------------ 

" Enable this line after the installation of glaive
call glaive#Install()        

"------------------------------------------------------------------------------
" Plug configuration 
"------------------------------------------------------------------------------
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

"------------------------------------------------------------------------------
" Declare the list of themes.

"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'KeitaNakamura/neodark.vim' "neodark
"Plug 'NLKNguyen/paperolor-theme' "PaperColor
"Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
"Plug 'dunstontc/vim-vscode-theme' "dark_plus
"Plug 'arcticicestudio/nord-vim' "nord
"Plug 'sainnhe/everforest'
" catppuccin colorscheme
"Plug 'catppuccin/vim', { 'as': 'catppuccin' }

"------------------------------------------------------------------------------
" Minimap
" Plug 'wfxr/minimap.vim'

"------------------------------------------------------------------------------
" Vimwiki
Plug 'vimwiki/vimwiki'

"------------------------------------------------------------------------------
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"------------------------------------------------------------------------------
" Load UltiSnips when editing bash files
Plug 'neoclide/coc-snippets'

"------------------------------------------------------------------------------
" UltiSnips is the ultimate solution for snippets in Vim. It has many features,
" speed being one of them.

Plug 'SirVer/ultisnips'

"------------------------------------------------------------------------------
" Snippets files for various programming languages.
Plug 'honza/vim-snippets'

"------------------------------------------------------------------------------
" Add icons to the pluggins
Plug 'ryanoasis/vim-devicons'

"------------------------------------------------------------------------------ 
" Add fzf plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"------------------------------------------------------------------------------ 
" Undotree plugin
Plug 'mbbill/undotree'

"------------------------------------------------------------------------------ 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
"Plug 'nlknguyen/copy-cut-paste.vim'

"------------------------------------------------------------------------------ 
" Go language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"------------------------------------------------------------------------------ 
" Format markdown tables
Plug 'dhruvasagar/vim-table-mode'

"------------------------------------------------------------------------------ 
" Folding code
Plug 'tmhedberg/SimpylFold'

"------------------------------------------------------------------------------ 
" Shell formater
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" gitgutter
Plug 'airblade/vim-gitgutter'

"------------------------------------------------------------------------------
" dasht docset documentation
Plug 'sunaku/vim-dasht'
" search related docsets
nnoremap <Leader>k :Dasht<Space>
" search ALL the docsets
nnoremap <Leader><Leader>k :Dasht!<Space>
"------------------------------------------------------------------------------

call plug#end()
"------------------------------------------------------------------------------

"Git Gutter
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0


" Color scheme
"set t_Co=256   " This is may or may not needed.
if has('termguicolors')
    set termguicolors
endif
"
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
" let g:everforest_background = 'soft'
" For better performance
" let g:everforest_better_performance = 1

" Set color scheme
" colorscheme everforest
colorscheme rosepine "no airline support
set background=dark
let g:lightline = {
      \ 'colorscheme': 'rosepine',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }

" Airline plugin - ENABLE THIS FOR everforest and comment out lightline
" let g:airline_theme = 'everforest'
" let g:airline_statusline_ontop=1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline#extensions#wordcount#enabled = 1
" let g:airline#extensions#hunks#no_zero_only = 1
" let g:airline_powerline_fonts = 1 

            

" Make background transparent
" highlight Normal guibg=NONE ctermbg=NONE
" Font
set guifont=Maple:h14

"------------------------------------------------------------------------------
"SimpylFold plugin
let g:SimpylFold_docstring_preview = 1
"------------------------------------------------------------------------------
" Cheat.sh plugin
let g:CheatSheetDisableFrameworkDetection=0

"------------------------------------------------------------------------------
" Snippets plugin
let g:UltiSnipsExpandTrigger="<c-l>"

"------------------------------------------------------------------------------
" Indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
let g:indentLine_char = '│'

"------------------------------------------------------------------------------
" Syntastic plugin
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " let g:syntastic_python_checkers = ['flake8']
" " let g:syntastic_python_checkers = ['autopep']
" let g:syntastic_python_checkers = ['black']
" let g:syntastic_shell_checkers = ['shellcheck']

"------------------------------------------------------------------------------
" codefmt plugin
augroup autoformat_settings
autocmd FileType c,cpp,proto,javascript,python3 AutoFormatBuffer clang-format
autocmd FileType python AutoFormatBuffer black
"autocmd FileType python AutoFormatBuffer yapf
augroup END
" use google style for clang-format
Glaive codefmt clang_format_style='google'

"------------------------------------------------------------------------------
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <silent> <F5> : NERDTreeToggle<CR>

" tagbar plugin
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;$HOME


"-------------------------------
" devicons plugin configuration
"-------------------------------
set guifont=DroidSansMono\ Nerd\ Font\ 14
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_ctlrp = 1

" Using ag to find files
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

"----------------
" VIMWIKI plugin
"----------------
let g:vimkwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" Navigate to the index page and generate links automatically
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
autocmd!
" automatically update links on read diary
autocmd BufRead,BufNewFile, diary.wiki VimwikiDiaryGenerateLinks
augroup end


let g:vimwiki_list = [{'path': '~/vimwiki/',
                  \ 'syntax': 'markdown', 'ext': '.md'}]
" Calendar path
let g:calendar_diary=$HOME.'/vimwiki/diary'

" vim-instant-markdown plugin
let g:instant_markdown_autostart = 0   " disable autostart
" Treat markdown files locally
let g:vimwiki_global_ext = 0

" Change between formats
function! ToggleMarkdown()
if &filetype == 'vimwiki'
    set ft=markdown
elseif &filetype == 'markdown'
    set ft=vimwiki
endif
endfunction

map <silent> <C-N> :call ToggleMarkdown()<CR>
"------------------------------------------------------------------------------
" FZF configuration
"------------------------------------------------------------------------------
" Use FZF with a preview pane
function! s:my_fzf_preview_command()
  let l:preview_command = 'bat --color=always --style=plain --line-range=:100 {}'
  return l:preview_command
endfunction

" Set fzf.vim preview settings
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ['right:60%:wrap', 'ctrl-/']
let g:fzf_action = {'enter': 'edit'}

let $FZF_DEFAULT_OPTS = '--preview-window=right:60%:wrap --preview ' . shellescape(s:my_fzf_preview_command())

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" FZF mappings for various fzf.vim features
nnoremap <silent> <leader>ff :FzfFiles<CR>
"Buffers
nnoremap <silent> <leader>fb :FzfBuffers<CR> 
"Docstrings
nnoremap <silent> <leader>fl :FzfLines<CR> 
"Tags
nnoremap <silent> <leader>ft :FzfTags<CR> 
"Tags in buffers
nnoremap <silent> <leader>fT :FzfBTags<CR> 
"History
noremap <silent> <leader>fh :FzfHistory:<CR> 
"Git files
nnoremap <silent> <leader>fg :FzfGFiles<CR> 
"Ripgrep
nnoremap <silent> <leader>rg :FzfRg<CR> 
"Marks
nnoremap <silent> <leader>fm :FzfMarks<CR> 
"Maps
nnoremap <silent> <leader>fM :FzfMaps<CR> 
"------------------------------------------------------------------------------
" Finding files
" Search down into subfolders from $HOME
set path+=**

"------------------------------------------------------------------------------

" Create the 'tags' file
command! MakeTags !ctags -R .
"
" Autogenerate tags on saving
" autocmd BufWritePost *.py,*.sh silent! !ctags &
" - Use Ctrl + ] to jump to tag under cursor
" - Use g] for ambiguous tags
" - Use Ctrl + t to jump back up the tag stack

"------------------------------------------------------------------------------

" NerdTree configuration

" Tweaks for browsing
let g:netrw_banner=0   " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"------------------------------------------------------------------------------
" Kotlin language server
autocmd BufReadPost *.kt setlocal filetype=kotlin

let g:LanguageClient_serverCommands = {
    \ 'kotlin': ["kotlin-language-server"],
    \ }
"------------------------------------------------------------------------------
" Autoformat rust
let g:rustfmt_autosave = 1
