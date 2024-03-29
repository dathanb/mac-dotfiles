" Append this to the end of .vimrc

:set fo-=tc
:set textwidth=160
:set ignorecase

" Always show line numbers
:set number

" Use the Source Code Pro font
:set guifont=SourceCodeVariable-Roman:h14

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

" Remap the leader to something more convenient than the backslash
" This shadows the original value of the semicolon, but that's fine - I never really use ftFT anyway
" let mapleader=";"

" Toggle NERDTree with ;t
nnoremap <leader>t :NERDTreeToggle<cr>
" auto-close NERDTree when opening a file
let NERDTreeQuitOnOpen=1

" Add mappings to move lines up and down 
nnoremap <C-S-j> :m .+1<CR>==
nnoremap <C-S-k> :m .-2<CR>==

" Auto-toggle between standard line numbers in normal mode and hybrid line numbers in insert mode
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

function! FreezeHeaderRow() abort
	" Maintain visual alignment of columns
  :set nowrap
  " don't auto-wrap long lines
  :set paste
  " create an extra window with only 1 line 
  :let l:windowId=win_getid()
  :1spl
  " register this window for auto-close when the other window is closed
  let w:shouldAutoClose=1
  " synchronize upper window
  :set scrollbind
  " Switch back to main window
  :call win_gotoid(l:windowId)
  " synchronize lower window
  :set scrollbind
	" synchronize horizontally
  :set sbo=hor
endfunction

if exists('##WinClosed')
  :autocmd WinClosed * :call CloseRelatedWindowsThisBuffer()
endif

function! CloseRelatedWindowsThisBuffer() abort
  let l:windowList=win_findbuf(bufnr())
  call win_execute(win_getid(), ":q")
  for l:winId in l:windowList
	  call win_execute(l:winId, "if get(w:, 'shouldAutoClose', 0) | ::q | endif")
  endfor
endfunction
