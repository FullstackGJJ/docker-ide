call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'luochen1990/rainbow'
Plug 'wlangstroth/vim-racket'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

let g:netrw_banner = 1

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

let lightcolors =  ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let darkcolors = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
let g:rainbow_conf = {'ctermfgs': darkcolors}

lua << END
require('lualine').setup{
    options = {
        icons_enabled = false,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' }
    }
}
END

lua << EOF
require('lspconfig').racket_langserver.setup{ cmd = { 'xvfb-run', '--auto-servernum', 'racket', '--lib', 'racket-langserver' }}
EOF

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <S-Up> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <S-Down> <cmd>lua vim.diagnostic.goto_next()<CR>

" auto-format
autocmd BufWritePre *.rkt lua vim.lsp.buf.formatting_sync(nil, 100)

" Using Lua telescope functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

syntax enable 
syntax on
filetype plugin indent on
set encoding=utf-8
set ruler number relativenumber
set hlsearch
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set autoindent
set pastetoggle=<f5>
set incsearch
set winminwidth=20
set winwidth=100
set winminheight=1
set winheight=55
colorscheme peachpuff

call setreg('z',':set nonumber:set norelativenumber','c')
call setreg('x',':set number:set relativenumber','c')
inoremap <C-K> <C-R>=SelectPrevAutoComplete()<CR>
inoremap <C-J> <C-R>=SelectNextAutoComplete()<CR>
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <Tab> <C-R>=TabOrComplete()<CR><C-R>=TabOrCompleteWithSingleMatch()<CR>
noremap <S-W> :w<CR>
noremap <S-E> :Explore<CR>
noremap <S-Right> gt
noremap <S-Left> gT
noremap <Right> l
noremap <Left> h
noremap <Up> k
noremap <Down> j
map <Space> <Plug>(easymotion-s)
map <leader>e <Plug>(easymotion-prefix)
vnoremap // y/<C-R>"<CR>
vnoremap <C-N> :normal 
vnoremap <C-C> "+y
vnoremap <C-K> :call FocusRange()<CR>:<BS>

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
