call plug#begin('~/.vim/plugged')

" VIM quality of life stuff
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'

" Useful lisp plugins
Plug 'luochen1990/rainbow'

" Conjure server plugin
Plug 'Olical/conjure'

" S-expression plugins
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Autocomplete functionality
Plug 'hrsh7th/nvim-cmp'
Plug 'tami5/compe-conjure'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Search functionality
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Status line functionality
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Aligning text
Plug 'godlygeek/tabular'

" Maintain nvim layout session
Plug 'tpope/vim-obsession'

call plug#end()

set completeopt=menu,menuone,noselect

let g:netrw_banner = 1

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

let lightcolors =  ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let darkcolors = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
let g:rainbow_conf = {'ctermfgs': darkcolors}

" Setting scheme client with chicken scheme
let g:conjure#client#scheme#stdio#command = "csi -quiet -:c"
let g:conjure#client#scheme#stdio#prompt_pattern = "\n-#;%d-> "

lua <<EOF

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    }),
    source = {
        conjure = true
      }
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

lua << END
  require('lualine').setup{
      options = {
          icons_enabled = false,
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '|', right = '|' }
      }
  }
END

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
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
noremap <S-W> :w<CR>
noremap <S-Right> gt
noremap <S-Left> gT
noremap <Right> l
noremap <Left> h
noremap <Up> k
noremap <Down> j
map <Space> <Plug>(easymotion-s)
map <leader><Space> <Plug>(easymotion-prefix)
vnoremap // y/<C-R>"<CR>
vnoremap <C-N> :normal 
vnoremap <C-C> "+y
vnoremap <C-K> :call FocusRange()<CR>:<BS>

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
