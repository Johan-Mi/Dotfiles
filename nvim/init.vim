cal plug#begin('~/.config/nvim/plugged')
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
	Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-commentary'
	Plug 'itchyny/lightline.vim'
	Plug 'ericcurtin/CurtineIncSw.vim'
	Plug 'joshdick/onedark.vim'
	Plug 'ryanoasis/vim-devicons'
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

hi Function		ctermfg=170	guifg=#C678DD
hi Statement	ctermfg=39	guifg=#61AFEF
hi Repeat		ctermfg=39	guifg=#61AFEF
hi Operator		ctermfg=39	guifg=#61AFEF
hi Conditional	ctermfg=39	guifg=#61AFEF
hi Number		gui=bold

com W w

let mapleader=" "

nn <Space>			§
ino jk				<Esc>
ino kj				<Esc>
ino <C-h>			<Left>
ino <C-j>			<Down>
ino <C-k>			<Up>
ino <C-l>			<Right>
nn <C-h>			<C-w>h
nn <C-j>			<C-w>j
nn <C-k>			<C-w>k
nn <C-l>			<C-w>l
ino <S-BS>			<BS>
ino <C-b>			<C-k>
nn <silent>;		:cal AddSemicolon()<CR>
nn !				:!
nn <leader>fs		:w<CR>
nn §				@:
map <kLeft>			<Left>
map <kDown>			<Down>
map <kUp>			<Up>
map <kRight>		<Right>
im <kLeft>			<Left>
im <kDown>			<Down>
im <kUp>			<Up>
im <kRight>			<Right>
xm <kLeft>			<Left>
xm <kDown>			<Down>
xm <kUp>			<Up>
xm <kRight>			<Right>
smap <kLeft>		<Left>
smap <kDown>		<Down>
smap <kUp>			<Up>
smap <kRight>		<Right>

nn <leader>cc			:!make<CR>
nn <leader>n			:!make&&./main<CR>
nn <leader>r			:!"%:p"<CR>
nn <leader>qq			:xa<CR>
nn <leader>qQ			:qa!<CR>
nn <leader>tr			:se ro!<CR>
nn <leader>cf			:Neoformat<CR>
nn <leader>pyl			:!pylint "%:p"<CR>
nn <silent><C-n>		:NERDTreeToggle<CR>

ino <silent><expr> <c-space> coc#refresh()
ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nm <silent>cd <Plug>(coc-definition)
" nm <silent> gy <Plug>(coc-type-definition)
" nm <silent> gi <Plug>(coc-implementation)
nm <silent>cD <Plug>(coc-references)
nn <silent> K :cal <SID>show_documentation()<CR>

nmap <leader>cr <Plug>(coc-rename)
" xmap <leader>f	<Plug>(coc-format-selected)
" nmap <leader>f	<Plug>(coc-format-selected)
xm <leader>a	<Plug>(coc-codeaction-selected)
nm <leader>a	<Plug>(coc-codeaction-selected)
nm <leader>ac  <Plug>(coc-codeaction)
nm <leader>qf  <Plug>(coc-fix-current)

ino <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" : "\<TAB>"
	" \ <SID>check_back_space() ? "\<TAB>" :
	" \ coc#refresh()
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

au BufWritePost Xresources	!xrdb "%:p"
au BufRead *.kojo			se syn=scala
au BufRead *.list			se syn=dosini
au BufRead *.lark			se ft=lark syn=scilab noet ts=4 sw=4
au BufRead *.py				se et ts=4 sw=4
au BufRead *.scratch		se ft=scratch syn=python noet
au BufRead *.json			se ts=2
au BufWritePre *			cal RemoveTrailingWhitespace()

fu! AddSemicolon()
	exe "normal! m`A;\<Esc>``"
endf

fu! RemoveTrailingWhitespace()
	norm! m`
	%s/\s\+$//e
	norm! ``
endf

fu! s:check_back_space() abort
	let col = col('.') - 1
	retu !col || getline('.')[col - 1]  =~# '\s'
endf

fu! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		exe 'h '.expand('<cword>')
	el
		cal CocAction('doHover')
	endif
endf

aug mygroup
	au!
	" Setup formatexpr specified filetype(s).
	au FileType typescript,json
		\ setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
aug end

" Use `:Format` to format current buffer
com! -nargs=0 Format :cal CocAction('format')

" Use `:Fold` to fold current buffer
com! -nargs=? Fold :cal	 CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
com! -nargs=0 OR   :cal
	\ CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin,
" checkout `:h coc-status`
se statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
