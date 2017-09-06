" Keeflizied nvim

" Plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'bwot/init.neovim'
  Plug 'flazz/vim-colorschemes'             " Hundreds of colorschemes o_O
  Plug 'itchyny/lightline.vim'              " Customizable statusline
  Plug 'yuttie/hydrangea-vim'
  Plug 'vimwiki/vimwiki'
call plug#end()


" Lightline config
let g:lightline = {
      \ 'colorscheme': 'hydrangea',
      \ }
let g:lightline.tabline  = {'right': [[]]}


" Saving folds
"augroup remember_folds
  "autocmd!
  "autocmd BufWinLeave *.* mkview
  "autocmd BufWinEnter *.* loadview
"augroup END


" Main Config
let mapleader=","                           " Use , instead of \ as leader
set background=dark                         " Use dark background
colorscheme hydrangea


" Key mappings
" Escape is very very far from the homerow
inoremap jj <esc>
" Stop the highlighting with ,space
nmap <Leader><Space> :noh<CR>
nmap <Leader><+> :hi\ VimwikiHeaderChar\ cterm=bold\ ctermfg=37\ gui=bold\ guifg=#00afaf<CR>
