cal plug#begin('~/.config/nvim/plugged')
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'tpope/vim-commentary'
	Plug 'itchyny/lightline.vim'
	Plug 'joshdick/onedark.vim'
	Plug 'inkarkat/vim-ingo-library'
	Plug 'inkarkat/vim-IndentConsistencyCop'
	Plug 'sbdchd/neoformat'
cal plug#end()

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
	\	'fileformat': '%{&ff=="unix"?"LF":&ff=="dos"?"CRLF":"CR"}',
	\	'percent': '%P',
	\	'readonly': '%{&readonly?"":""}'
	\	},
	\ 'mode_map': {
	\	'n' : '', 'i' : '', 'R' : '', 'v' : '', 'V' : '', "\<C-v>": '',
	\	'c' : '', 's' : '', 'S' : '', "\<C-s>": '', 't': '',
	\	},
	\ }
let g:lightline.inactive = g:lightline.active

sy on
colo onedark
se tgc

se nu rnu
se ts=4 sw=4
se so=7
se ic
se sb spr
se tw=80 cc=+1
se cul
se nohls
se list lcs=tab:│\ "Trailing space
se fo-=t

se hid
se nobk nowb
se ut=300
se shm+=c
se scl=no

hi colorcolumn	ctermbg=232	guibg=#080808
hi CursorLine	ctermbg=233	guibg=#0e0e0e
hi CursorColumn	ctermbg=233	guibg=#0e0e0e
hi CursorLineNr	ctermbg=233	guibg=#0e0e0e
hi WhiteSpace	ctermfg=234	guifg=#1a1a1a
hi Normal		guibg=none

hi Function		ctermfg=170	guifg=#C678DD
hi Statement	ctermfg=39	guifg=#61AFEF
hi Repeat		ctermfg=39	guifg=#61AFEF
hi Operator		ctermfg=39	guifg=#61AFEF
hi Conditional	ctermfg=39	guifg=#61AFEF
hi Number		gui=bold

com W w

let mapleader=" "

nn <Space>					§
ino jk						<Esc>
ino kj						<Esc>
ino <C-h>					<Left>
ino <C-j>					<Down>
ino <C-k>					<Up>
ino <C-l>					<Right>
nn <C-h>					<C-w>h
nn <C-j>					<C-w>j
nn <C-k>					<C-w>k
nn <C-l>					<C-w>l
ino <S-BS>					<BS>
ino <C-b>					<C-k>
nn <silent>;				m`A;<Esc>``
nn !						:!
nn §						@:
ino {<CR>					{<CR>}<C-o>O
nn g<						<CMD>tabm -<CR>
nn g>						<CMD>tabm +<CR>

nn <leader>fs				<CMD>w<CR>
nn <leader>cc				<CMD>!make<CR>
nn <leader>n				<CMD>!make&&./main<CR>
nn <leader>r				<CMD>!"%:p"<CR>
nn <leader>qq				<CMD>xa<CR>
nn <leader>qQ				<CMD>qa!<CR>
nn <silent><leader>tr		<CMD>se ro!<CR>
nn <leader>cf				<CMD>Neoformat<CR>
nn <leader>pyl				<CMD>!pylint "%:p"<CR>

ino <silent><expr><c-space>	coc#refresh()
ino <expr><cr>				pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nm <silent>cd				<Plug>(coc-definition)
nm <silent>cD				<Plug>(coc-references)
nn <silent> K				<CMD>cal <SID>show_documentation()<CR>

nm <leader>cr				<Plug>(coc-rename)
xm <leader>a				<Plug>(coc-codeaction-selected)
nm <leader>a				<Plug>(coc-codeaction-selected)
nm <leader>ac				<Plug>(coc-codeaction)
nm <leader>qf				<Plug>(coc-fix-current)

ino <silent><expr><TAB>		pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><S-TAB>			pumvisible() ? "\<C-p>" : "\<C-h>"

au BufWritePost Xresources	!xrdb "%:p"
au BufRead *.lark			se ft=lark syn=scilab noet ts=4 sw=4
au BufRead *.py				se et ts=4 sw=4
au BufRead *.scratch		se ft=scratch syn=python noet
au BufRead *.json			se ts=2

fu! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		exe 'h '.expand('<cword>')
	el
		cal CocAction('doHover')
	en
endf
