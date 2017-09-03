
call plug#begin('~/.config/nvim/plugged')
  Plug 'bwot/init.neovim'
  Plug 'flazz/vim-colorschemes'             " Hundreds of colorschemes o_O
  Plug 'itchyny/lightline.vim'              " Customizable statusline
  Plug 'vimwiki/vimwiki'
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let mapleader=","                           " Use , instead of \ as leader
set background=dark                         " Use dark background
colorscheme PaperColor                      " From flazz/vim-colorschemes


" Escape is very very far from the homerow
inoremap jj <esc>
" Stop the highlighting with ,space
nmap <Leader><Space> :noh<CR>
nmap <Leader><+> :hi\ VimwikiHeaderChar\ cterm=bold\ ctermfg=37\ gui=bold\ guifg=#00afaf<CR>
