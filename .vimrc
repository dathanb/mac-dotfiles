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
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Always show the status line
:set laststatus=2
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#StatusLine#
set statusline+=\ %F
set statusline+=%m\ 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

" don't unload buffers or prompt to save when switching
:set hidden

" Colors!!
set termguicolors

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

