call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-vinegar'

call plug#end()

let g:netrw_banner = 1
let g:deoplete#enable_at_startup = 1

let g:ale_linters = {
      \   'ruby': ['standardrb', 'rubocop'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \}

:syntax enable 
:syntax on
:filetype plugin indent on
:set encoding=utf-8
:set ruler number relativenumber
:set hlsearch
:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
:set autoindent
:set pastetoggle=<f5>
:set incsearch
:set winminwidth=20
:set winwidth=100
:set winminheight=1
:set winheight=55
:colorscheme peachpuff

:call setreg('z',':set nonumber:set norelativenumber','c')
:call setreg('x',':set number:set relativenumber','c')
:inoremap <C-K> <C-R>=SelectPrevAutoComplete()<CR>
:inoremap <C-J> <C-R>=SelectNextAutoComplete()<CR>
:inoremap <C-H> <Left>
:inoremap <C-J> <Down>
:inoremap <C-K> <Up>
:inoremap <C-L> <Right>
:inoremap <Tab> <C-R>=TabOrComplete()<CR><C-R>=TabOrCompleteWithSingleMatch()<CR>
:noremap <S-W> :w<CR>
:noremap <S-E> :Explore<CR>
:noremap <S-Right> gt
:noremap <S-Left> gT
:noremap <Right> l
:noremap <Left> h
:noremap <Up> k
:noremap <Down> j
:noremap <C-J> gg/<CR>
:noremap <C-K> G?<CR>
:map <Space> <Plug>(easymotion-s)
:map \ <Plug>(easymotion-prefix)
:noremap <C-H> _
:noremap <C-L> $
:noremap <C-CR> <S-V>"+y
:vnoremap // y/<C-R>"<CR>
:vnoremap <C-N> :normal 
:vnoremap <C-C> "+y
:vnoremap <C-K> :call FocusRange()<CR>:<BS>

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

function! TabOrComplete()
    if col('.')>1 && strpart(getline('.'), col('.')-2, 3) =~ '^\w'
        return "\<C-N>\<C-P>"
    else
        return "\<Tab>"
    endif
endfunction

function! SelectPrevAutoComplete()
    if pumvisible() != 0
        return "\<C-P>"
    else
        return "\<C-K>"
    endif
endfunction

function! SelectNextAutoComplete()
    if pumvisible() != 0
        return "\<C-N>"
    else
        return "\<C-J>"
    endif
endfunction

function! TabOrCompleteWithSingleMatch()
    if col('.')>1 && strpart(getline('.'), col('.')-2, 3) =~ '^\w' && pumvisible() == 0
        return "\<C-N>"
    elseif col('.')>1 && strpart(getline('.'), col('.')-2, 3) =~ '^\w'
        return "\<C-N>\<C-P>"
    else
        return ""
    endif
endfunction

function! TotalMatches()
    %s///gn
endfunction

function! AlignToColumn(column)
    let currentPosition = virtcol(".")
    let offset = a:column - currentPosition
    if a:column > currentPosition
        :execute ":normal" currentPosition . "|" . offset . "i " . "\<Esc>"
    elseif a:column < currentPosition
        :execute ":normal" currentPosition . "|" . "d" . -offset . "h"
    else
    endif
endfunction

function! FocusRange() range
    if a:firstline > 1
        let aboveLine = a:firstline - 1
    else
        let aboveLine = 1
    endif
    if a:lastline < line('$')
        let belowLine = a:lastline + 1
    else
        let belowLine = line('$')
    endif
    :execute ":1," . aboveLine . "fold"
    :execute ":" . belowLine . "," . line('$') . "fold"
endfunction
