call plug#begin('~/.config/nvim/plugged')
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'tpope/vim-commentary'
	Plug 'itchyny/lightline.vim'
	Plug 'joshdick/onedark.vim'
	Plug 'sbdchd/neoformat'
	Plug 'cespare/vim-toml'
call plug#end()

let g:neoformat_basic_format_retab=0

let g:lightline = {
	\ 'colorscheme': 'modeline',
	\ 'subseparator': { 'left': '', 'right': '' },
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 	          [ 'readonly' ],
	\             [ 'filename', 'modified'],
	\ 	          [ 'lineinfo', 'percent' ] ],
	\ 	'right': [ [ 'filetype' ],
	\ 	           [ 'fileformat', 'fileencoding' ] ]
	\ 	},
	\ 'component': {
	\ 	'fileformat': '%{&ff=="unix"?"LF":&ff=="dos"?"CRLF":"CR"}',
	\ 	'percent': '%P',
	\ 	'readonly': '%{&readonly?"":""}'
	\ 	},
	\ 'mode_map': {
	\ 	'n' : '', 'i' : '', 'R' : '', 'v' : '', 'V' : '', "\<C-v>": '',
	\ 	'c' : '', 's' : '', 'S' : '', "\<C-s>": '', 't': '',
	\ 	},
	\ }
let g:lightline.inactive = g:lightline.active

syntax on
colorscheme onedark
set termguicolors

set number relativenumber
set tabstop=4 shiftwidth=4
set scrolloff=7
set smartcase nohlsearch
set splitbelow splitright
set textwidth=80 colorcolumn=+1
set cursorline cursorcolumn
set list listchars=tab:¦\ "Trailing space
set formatoptions-=t
set clipboard=unnamedplus

set hidden
set nobackup nowritebackup
set shortmess+=cI
set signcolumn=no

highlight colorcolumn	ctermbg=232	guibg=#080808
highlight CursorLine	ctermbg=233	guibg=#0e0e0e
highlight CursorColumn	ctermbg=233	guibg=#0e0e0e
highlight CursorLineNr	ctermbg=233	guibg=#0e0e0e
highlight WhiteSpace	ctermfg=234	guifg=#303030
highlight StatusLine				guibg=#0b0b0b
highlight Pmenu						guibg=#121212

let mapleader=" "

nore <Space>				§
ino jk						<Esc>
ino kj						<Esc>
nn <C-h>					<C-w>h
nn <C-j>					<C-w>j
nn <C-k>					<C-w>k
nn <C-l>					<C-w>l
ino <C-h>					<BS>
ino <C-b>					<C-k>
nn <silent>;				m`A;<Esc>``
nn !						:!
nn §						@:
nn g<						<CMD>tabmove -<CR>
nn g>						<CMD>tabmove +<CR>
nn <TAB>					gt
nn <s-TAB>					gT

nn <leader>fs				<CMD>w<CR>
nn <leader>cc				<CMD>!make<CR>
nn <silent><leader>cl		<CMD>silent !make clean<CR>
nn <leader>n				<CMD>call <SID>compile_and_run()<CR>
nn <leader>d				<CMD>!cargo doc<CR>
nn <leader>r				<CMD>!"%:p"<CR>
nn <leader>qq				<CMD>xa<CR>
nn <leader>qQ				<CMD>qa!<CR>
nn <leader>cf				<CMD>Neoformat<CR>
nn <leader>cF				<CMD>call CocAction("format")<CR>
nn <leader>tt				:tabe<Space>
nn <leader>gg				<CMD>execute '!git grep' expand('<cword>')<cr>
nn <leader>uw				m`dwxf>x``
nn <leader>uW				m`dwr&f>x``
nn <leader>qf				<CMD>CocFix<CR>
nn <leader>l				<CMD>!cargo clippy<CR>
ino <silent><expr><c-space>	coc#refresh()
ino <expr><cr>				pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nm <silent><leader>cd		<Plug>(coc-definition)
nm <silent><leader>cD		<Plug>(coc-references)
nn <silent>K				<CMD>call <SID>show_documentation()<CR>
nm <leader>cr				<Plug>(coc-rename)
nore <space><space>			:
ino <silent><expr><TAB>		pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><S-TAB>			pumvisible() ? "\<C-p>" : "\<C-h>"

autocmd BufWritePost Xresources	!xrdb "%:p"
autocmd BufRead *.py			set expandtab tabstop=4 shiftwidth=4
autocmd BufRead *.json			set tabstop=2
autocmd BufWritePre *.rs		Neoformat

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h ' . expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

function! s:compile_and_run()
	silent !cargo locate-project
	if v:shell_error == 0
		!cargo run
	else
		!make&&./main
	endif
endfunction
