" Append this to the end of .vimrc
"
" NERDTreee
:nnoremap <D-1> :NERDTreeToggle<cr>

:set fo-=tc
:set textwidth=120

" Always show line numbers
:set number

" Use the Source Code Pro font
:set guifont=SourcecodeVariable-Roman:h12

" Use the Darcula color scheme
:syntax enable
:colorscheme darcula

" Enable pathogen
:execute pathogen#infect()
:syntax on
:filetype plugin indent on

" tabs
:filetype plugin indent on
:set tabstop=4
:set shiftwidth=4
:set expandtab

" don't unload buffers or prompt to save when switching
:set hidden

" Colors!!
set termguicolors

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

