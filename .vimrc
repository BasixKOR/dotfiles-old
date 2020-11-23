set smartindent
set tabstop=4
set expandtab
set shiftwidth=4

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp949,default,latin1

" Asked by coc.nvim
set updatetime=300
set nobackup
set nowritebackup
set hidden
set signcolumn=yes

" Line numbers
set number
set cursorline

call plug#begin(stdpath('data') . '/plugged')
Plug 'phanviet/vim-monokai-pro'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot' " Comes with vim-sensible
Plug 'mhinz/vim-signify'
Plug 'wakatime/vim-wakatime'
Plug 'lambdalisue/battery.vim'
Plug 'simnalamburt/vim-mundo'
call plug#end()

let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-git',
\ 'coc-html',
\ 'coc-css',
\ 'coc-java',
\ 'coc-json',
\ 'coc-rust-analyzer',
\ 'coc-styled-components',
\ 'coc-eslint',
\ 'coc-python',
\ 'coc-yaml',
\ 'coc-vetur',
\ 'coc-prisma',
\ 'coc-eslint',
\ 'coc-tabnine',
\ 'coc-tailwindcss',
\ 'coc-discord-rpc'
\ ]

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:airline_theme='base16_monokai'

syntax on
set termguicolors
colorscheme monokai_pro

map <C-n> :NERDTreeToggle<CR>
map <C-g> :Goyo<CR>

" coc.nvim settings

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd CursorHold * silent call CocActionAsync('highlight')

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif


" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
