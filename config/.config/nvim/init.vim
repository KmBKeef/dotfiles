" vim:foldmethod=marker:foldlevel=0
" zo + zc to open / close folds in case I forgot :P

" PLUG {{{

call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

source /home/mk/.config/nvim/plugged/dragvisuals.vim
" Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tweekmonster/deoplete-clang2'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim' " gc comments
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
" Plug 'thirtythreeforty/lessspace.vim'
Plug 'vim-airline/vim-airline'
Plug 'neomake/neomake'
" Plug 'w0rp/ale'
Plug 'zchee/deoplete-jedi'

" Fix history issue
" let g:jedi#show_call_signatures = "0"
let g:jedi#completions_enabled = 1
" Neomake auto on save
autocmd! BufWritePost * Neomake
" UltiSnipps configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnippsJumpBackwardTrigger="<c-z>"

" lightline configuration
" let g:lightline = {
"       \ 'colorscheme': 'nord',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head'
"       \ },
"       \ }


call plug#end()
" }}}
" PLUGINS + CUSTOM FUNCTIONS {{{
" Custom
 source ~/.config/nvim/custom/functions.vim
 nnoremap <leader>t :call ToggleTodo()<cr>
 vnoremap <leader>t :call ToggleTodo()<cr>
 nnoremap <leader>T :call ToggleTodoToday()<cr>
 vnoremap <leader>T :call ToggleTodoToday()<cr>

" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="❱"
let g:airline_right_sep=""
let g:airline_right_alt_sep="❰"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#hunks#enabled = 0
" let g:airline_section_z = ""
if get(g:, 'airline_theme', 'notloaded') == 'notloaded'
  source ~/.config/nvim/custom/customairline.vim
  let g:airline_theme="customairline"
endif

" deoplete
let g:deoplete#enable_at_startup=1
"  let g:deoplete#sources#clang#libclang_path='/usr/lib64/libclang.so.4.0'
"  let g:deoplete#sources#clang#clang_header='/usr/lib64/clang/4.0.0/include/'

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

" NERDTree
" Open NERDTree in the directory of the current file (or /home if no file is open)
" let NERDTreeShowHidden=1

" function! NERDTreeToggleFind()
"   if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
"     execute ":NERDTreeClose"
"   else
"     execute ":NERDTreeFind"
"   endif
" endfunction

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nnoremap <leader>c :call NERDTreeToggleFind()<cr>

"Tab
" function! Tab_Or_Complete()

"     return "\<Tab>"
"   endif
" endfunction
" inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


" au BufNewFile,BufRead *.txt,*.md
" set dictionary="/usr/share/dict/words"
" set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
" set complete+=k

"Ripgrep for search
if executable('rg')
  set grepprg=rg\ -i\ --vimgrep

  " Ripgrep on /
  command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  nnoremap <leader>/ :Rg<SPACE>
endif

" airline
set laststatus=2
" let g:airline_left_sep=""
" let g:airline_left_alt_sep="|"
" let g:airline_right_sep=""
" let g:airline_right_alt_sep="|"
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_tab_nr = 1
" let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#show_buffers = 0
" " let g:airline#extensions#hunks#enabled = 0
" " let g:airline_section_z = ""
" if get(g:, 'airline_theme', 'notloaded') == 'notloaded'
"   source ~/.config/nvim/custom/customairline.vim
"   let g:airline_theme="customairline"
" endif

" FZF
function! Fzf_tags_sink(line)
  " Split line in tags file by parts, jump to file + line number
  " <tag><TAB><file><TAB><lineNumber>
  let parts = split(a:line, '\t')
  " execute 'silent e' parts[1]
  execute 'silent :tabedit' parts[1]
  execute 'normal! ' . parts[2] . 'G'
endfunction

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
endif

let g:fzf_command_prefix = 'Fzf'
let fzf_tags_sink = {'sink': function('Fzf_tags_sink')}
if executable('fzf')
  nnoremap <leader>v :FzfFiles<cr>
  nnoremap <leader>u :call fzf#vim#tags("", fzf_tags_sink)<cr>
  nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'), fzf_tags_sink)<cr>
else
  nnoremap <leader>v :CtrlP<Space><cr>
endif
"===== From DC ===="

" function! HLNext (blinktime)
"   let [bufnum, lnum, col, off] = getpos('.')
"   let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"   let target_pat = '\c\%#\%('.@/.'\)'
"   let ring = matchadd('DiffText', target_pat, 101)
"   redraw
"   exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"   call matchdelete(ring)
"   redraw
" endfunction

      " }}}
" LOOK AND SYNTAX HILIGHTING {{{
set t_Co=256
syntax on
set noshowmode
set background=dark
colorscheme nord
set guifont=hack
" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL

" Undefined Marks
highlight UndefinedMarks ctermfg=yellow
autocmd Syntax * syn match UndefinedMarks /???/ containedin=ALL

" Automatic syntax highlighting for files
au BufRead,BufNewFile *.txt     set filetype=markdown
au BufRead,BufNewFile *.wiki    set filetype=vimwiki
" au BufRead,BufNewFile *.wiki    colorscheme darkblue
au BufRead,BufNewFile *.conf    set filetype=dosini
au BufRead,BufNewFile *.bash*   set filetype=sh
au BufRead,BufNewFile *.jsonnet*   set filetype=c
au BufRead,BufNewFile *.libsonnet*   set filetype=c
au BufRead,BufNewFile todo*   set filetype=todo

" show characters
" set list
" set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
" set showbreak=↪
" Better split character
" Override color scheme to make split them black
" set fillchars=vert:\|
set fillchars=vert:│
   highlight ColorColumn ctermbg=magenta
   call matchadd('ColorColumn', '\%81v', 100)
" set colorcolumn=81
set cursorline
" }}}
" KEYMAPPINGS {{{
" Leader key
let mapleader = ","

" arrow keys disable / use up and down to move current line
nnoremap <right> <nop>
nnoremap <down> ddp
nnoremap <left> <nop>
nnoremap <up> ddkP

vnoremap <right> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <up> <nop>

" j/k move virtual lines, gj/jk move physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Remap increment and decrement numbers to something that works on macs/linux
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" panes
nnoremap <leader>d :vsp<CR>
set splitright
nnoremap <leader>s :split<CR>
set splitbelow

" map <C-w>w (switch buffer focus) to something nicer
nnoremap <leader>w <C-w>w

" tabs
nnoremap <leader>] :tabn<CR>
nnoremap <leader>[ :tabp<CR>

" Insert datecrcr
nnoremap <leader>fd "=strftime("%m-%d-%y")<CR>p

" Edit vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>evs :source $MYVIMRC<cr>

" Quickfix toggle
nnoremap <leader>q :call QuickfixToggle()<cr>

" dragvisuals
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')

vmap <expr> D DVB_Duplicate()

" Always center
nmap G Gzz
nmap N Nzz
nmap n nzz
nmap { {zz
nmap } }zz

" Use the Useful one
nnoremap ; :
" nnoremap : ;

nnoremap v <C-v>
nnoremap <C-v> v


nnoremap <leader>c :NERDTreeToggle<cr>
"

" }}}
" BRACE & ",',<> COMPLETION {{{
set showmatch
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {}     {}


inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap ()     ()
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap []     []

inoremap '      ''<LEFT>
inoremap "      ""<LEFT>
inoremap <leader>' '
inoremap <leader>" "

" }}}
" GENERAL/TOGGLEABLE SETTINGS {{{
" horizontal split splits below
set splitbelow

" indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
filetype indent off

au BufNewFile,BufRead *.py
  \ setlocal tabstop=4
  \ shiftwidth=4
  \ softtabstop=4
  \ autoindent
  \ expandtab

" line numbers
set number
set relativenumber

" show title
set title

" show list
set list
" mouse
set mouse-=a

" utf-8 ftw
" nvim sets utf8 by default, wrap in if because prevents reloading vimrc
if !has('nvim')
  set encoding=utf-8
endif

" Ignore case unless use a capital in search (smartcase needs ignore set)
set ignorecase
set smartcase

" Textwidth for folding
set textwidth=100

" Disable cursor styling in new neovim version
set guicursor=
" }}}
