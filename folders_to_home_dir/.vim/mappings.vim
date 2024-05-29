" Vim mappings
" -------------


 " Autopep format for Python
au FileType python setlocal formatprg=black\ -

" Leader key
let mapleader = "\<Space>"

" Termwinkey

" Move from terminal to window
" Example: C-t k
set termwinkey=<C-T>

" Open term
nnoremap <leader>t :term<CR>

" Switch from terminal mode to normal mode
tnoremap <C-x> <C-\><C-n>
"
" InstantMarkdownPreview
map <leader>md :InstantMarkdownPreview<CR>

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" .vimrc modifications
nnoremap <leader>mv :tabnew $MYVIMRC<CR>
nnoremap <leader>rv :source $MYVIMRC"<CR>

" Copy of .vimrc
nnoremap <leader>cv :!cp ~/.vimrc "vimcopy-$(uname -n)-$(date)"<CR><Esc>

" Esc key
inoremap kj <Esc>
cnoremap kj <Esc>
inoremap jk <Esc>
cnoremap jk <Esc>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Tab keys
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tj :tabprev<CR>
nnoremap <leader>tk :tabnext<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>tn :tabnew <Space> 
nnoremap <leader>ts :tabs<CR>

" No hls. Unselect marked words
nnoremap <leader>nh :nohls<CR>

" Surround the block with quotes
vnoremap <leader>vc :s/\%V\(^.*$\)/`&`/g<CR>gv

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual selection one line below
vnoremap J :m'>+1<cr>gv=gv

" Move visual selection one line up
vnoremap K :m'<-2<cr>gv=gv

" Which bash
nnoremap <leader>wb :.!which bash<CR>I#!<Esc>

" Which python3
nnoremap <leader>wp :.!which python3<CR>I#!<Esc>

" Which ruby
nnoremap <leader>wrb :.!which ruby<CR>I#!<Esc>

" Which lua
nnoremap <leader>wl :.!which lua<CR>I#!<Esc>

" Append date
nnoremap <leader>ad :.!date<CR>I# Date: <Esc>

" Underline word
nnoremap <leader>0 yyp<c-v>$r=A<CR><Esc>

" Insert 79 #
nnoremap <leader>7 i#<esc>79a#<esc>

" Insert word in a box
nnoremap <leader>8 yyp<c-v>$r-A<Esc>yy1kP<Esc>

" Underline word
nnoremap <leader>9 yyp<c-v>$r-A<CR><Esc>
inoremap <leader>9 <Esc>yyp<c-v>$r-A<CR>

" Compile current C file
nnoremap <leader>gc :!gcc -Wall -Wextra -g -std=c11 -o %< %<.c<CR>
nnoremap <leader>gcp :!g++ -Wall -Wextra -g -std=c++17 -o %< %<.cpp<CR>
nnoremap <leader>gcn :!gcc -Wall -Wextra -g -std=c11 -o %< -lncurses %<.c<CR>
nnoremap <leader>gcs :!gcc -Wall -Wextra -g -std=c11 -o %< -lsqlite3 %<.c<CR>
nnoremap <leader>cf :%!clang-format<CR>

" Compile current rust file
nnoremap <leader>rc :!rustc %<CR>
" Run rust file
nnoremap <leader>rr :!./main <CR>

" Run python code
nnoremap <leader>rp :!python3 %<Esc>

" Run lua code
nnoremap <leader>rl :!lua %<Esc>

" Run bash code
nnoremap <leader>rb :!bash %<Esc>

" Run go code
nnoremap <leader>gl :!go run %<Esc>
nnoremap <leader>gb :!go build %<Esc>

" Make file executable
nnoremap <leader>x :!chmod +x %<CR>

" Comment block in Python and Bash
vnoremap <leader>c :normal I#<CR><Esc>

" Uncomment block
vnoremap <leader>u :normal ^x <CR><Esc>

" Save selected text in vmode
vnoremap <leader>s :w <C-R>=input("Save to file: ")<CR><Esc>

" Write as sudo
nnoremap <leader>ws :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" Set language
nnoremap <F2> :setlocal spell spelllang=es<CR>
nnoremap <F3> :setlocal spell spelllang=en_us<CR>

" Clipboard 
" For using in Macos
" vnoremap <leader> <C-y> :w !pbcopy<CR><CR>
" nnoremap <leader> <C-p> :r !pbpaste<CR>
"nnoremap <leader> <C-p> "+p

" Paste from clipboard X11
nnoremap <F4> :r !xclip -o -sel clip<Esc>
" Copy from visual mode
vnoremap <F6> :w !xclip -i -sel clip<CR><CR>

" Clipboard wayland
" Copy from visual mode to wayland clipboard
" vnoremap <silent> <C-c> :w !wl-copy <CR><CR>
" Paste from wayland clipboard 
nnoremap <silent> <C-i> :r !wl-paste <ESC>


"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

map <silent> <F5> : NERDTreeToggle<CR>

" Tagbar plugin
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;$HOME

" Enable/Disable touchpad in insert mode
inoremap <F9> <Esc>:!xinput disable 11<CR>i
inoremap <F10> <Esc>:!xinput enable 11<CR>i"

" MACROS FOR ACTING ON WORDS
"
" Surround word with quotes
nnoremap <leader>qwa Bi"<Esc>Ea"<Esc>
" Surround word with markdown code
nnoremap <leader>qwc Bi`<Esc>Ea`<Esc>
" Surround word with markdown bold
nnoremap <leader>qwb Bi**<Esc>Ea**<Esc>
" Surround word with markdown italics
nnoremap <leader>qws Bi*<Esc>Ea*<Esc>
" Surround word with markdown inline code
nnoremap <leader>qwi Bi$<Esc>Ea$<Esc>

" MACROS FOR ACTING ON LINES
"
" Surround line with quotes
nnoremap <leader>qla I"<Esc>$A"<Esc>
" Surround line with markdown code
nnoremap <leader>qlc I`<Esc>$A`<Esc>
" Surround line marked with code with bold 
nnoremap <leader>qlb I**<Esc>$A**<Esc>
" Surround line with Italics
nnoremap <leader>qls I*<Esc>$A*<Esc>
" Surround word with markdown inline code
nnoremap <leader>qli I$<Esc>$A$<Esc>

" Move between windows
" move right
nnoremap <leader>mwr <C-W><C-L>
" move left
nnoremap <leader>mwl <C-W><C-H>
" move down
nnoremap <leader>mwd <C-W><C-J>
" move up
nnoremap <leader>mwu <C-W><C-K>

" Split windows

" split window vertically
nnoremap <leader>v :vsplit<CR>
" split window horizontally
nnoremap <leader>- :split<CR>
" make splitted windows equal width
nnoremap <leader>= <C-W>=
"close current splitted window
nnoremap <leader>c :close<CR>

" Resize windows
nnoremap <C-up> :resize -2<CR>
nnoremap <C-down> :resize +2<CR>
nnoremap <C-left> :vertical resize -2<CR>
nnoremap <C-right> :vertical resize +2<CR>

" Vimwiki 
" Vimwiki Diary mappings

" Index
nnoremap <leader>wdi :VimwikiDiaryIndex<CR>

" Make note
nnoremap <leader>wdn :VimwikiMakeDiaryNote<CR>

" Make yesterday note
nnoremap <leader>wdy :VimwikiMakeYesterdayDiaryNote<CR>

" Make tomorrow note
nnoremap <leader>wdt :VimwikiMakeTomorrowDiaryNote<CR>

" Generate links
nnoremap <leader>wdl :VimwikiDiaryGenerateLinks<CR>

" Vimwiki Tables mappings
" Create table
nnoremap <leader>wt :VimwikiTable<CR>

" VimwikiRenameFile mappings
nnoremap <leader>rf :VimwikiRenameFile<esc>

" Vimwiki TOC
nnoremap <leader>wtoc :VimwikiTOC<esc>

" VimWikiTags
 "Tagbar integration                                            *vimwiki-tagbar*
 "
 "As an alternative to the Table of Contents, you can use the Tagbar plugin
 ""(https://preservim.github.io/tagbar/) to show the headers of your wiki files
 "in a side pane.
 "Download the Python script from
 "https://raw.githubusercontent.com/vimwiki/utils/master/vwtags.py and follow
 "the instructions in it.

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/bin/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }

" Vimwiki colorize line
nnoremap <leader>wc

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Save the folds
augroup remember_folds
autocmd!
autocmd BufWinLeave, BufLeave ?* silent! mkview
autocmd BufWinEnter *.* silent! loadview 
augroup END

" Persistent undo
nnoremap <leader>u :UndotreeToggle<CR>
set undofile
set undodir=~/.vim/undodir

" Show buffers
nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<leader>
" Delete all buffers but this one
nnoremap <silent> <leader>cab :update <bar> %bd <bar> e# <bar> bd# <CR><CR>

" Disable arrow keys
no <down> <Nop>
no <up> <Nop>
no <left> <Nop>
no <right> <Nop>

ino <down> <Nop>
ino <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>

vno <down> <Nop>
vno <up> <Nop>
vno <left> <Nop>
vno <right> <Nop>

" Some abbreviations
iabbr clm Carlos Lacaci Moya
"iabbr email nisidabay@gmail.com
"iabbr true True
"iabbr false False

" Command mode abreviations for saving and quitting
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Some macros
" Add header to python_nuggets.py
let @h = "I\u2022\u2022\u2022"

" split the lines in 80 characters
let @l = "080li ya0"


" python help
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \|
\ set iskeyword+=. \|
\ execute "!pydoc3 " . expand("<cword>") \|
\ let &iskeyword = save_isk<cr>
"
" search related docsets
nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>

" search ALL the docsets
nnoremap <silent> <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>
" search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

" sourcery
nnoremap <silent> <leader>cl :CocDiagnostics<cr>
nnoremap <silent> <leader>ch :call CocAction('doHover')<cr>
nnoremap <silent> <leader>cc <plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>ca <plug>(coc-fix-current)
nnoremap <silent> <leader>fi :CocCommand python.sortImports<CR>

" diagnostic
nnoremap <silent> <leader> dp: <plug>(coc-diagnostic-prev)
nnoremap <silent> <leader> dn: <plug>(coc-diagnostic-next)

" Load termdebug
let g:termdebug_wide=1


