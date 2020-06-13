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

sy on
colo onedark

se nu rnu
se ts=4 sw=4
se so=7
se ic
se sb spr
se tw=80 cc=+1
se cul cuc
se list lcs=tab:│\ "Trailing space

hi Normal		ctermbg=NONE
hi colorcolumn	ctermbg=232
hi CursorLine	ctermbg=233
hi CursorColumn	ctermbg=233
hi WhiteSpace	ctermfg=234

com W w

let mapleader=","

ino jk				<Esc>
ino kj				<Esc>
ino <C-h>			<Left>
ino <C-j>			<Down>
ino <C-k>			<Up>
ino <C-l>			<Right>
ino <S-BS>			<BS>
ino <C-b>			<C-k>
nn ;				:cal AddSemicolon()<CR>
nn !				:!
nn ZW				:w<CR>
nn §				@:

nn <silent><leader>h	:nohl<CR>
nn <leader>m			:!make -j4<CR>
nn <leader>n			:!make -j4&&./main<CR>
nn <leader>r			:!"%:p"<CR>
nn <leader>f			m`gg=G``
nn <leader>pyl			:!pylint "%:p"<CR>
map <F5>				:cal CurtineIncSw()<CR>
nn <C-n>				:NERDTreeToggle<CR>

fu! AddSemicolon()
	exe "normal! m`A;\<Esc>``"
endf

au BufWritePost Xresources	!xrdb "%:p"
au BufRead *.kojo			se syn=scala
au BufRead *.lark			se ft=lark syn=scilab
au BufRead *.py				se et ts=4 sw=4
au BufRead *.scratch		se ft=scratch syn=go
au BufRead *.json			se ts=2
aut BufWritePre *			cal RemoveTrailingWhitespace()

fu! RemoveTrailingWhitespace()
	norm! m`
	%s/\s\+$//e
	norm! ``
endf

let g:neoformat_basic_format_retab=0

" if hidden is not set, TextEdit might fail.
se hid

" Some servers have issues with backup files, see #649
se nobk nowb

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages
" when it's default 4000.
se ut=300

" don't give |ins-completion-menu| messages.
se shm+=c

" never show signcolumns
se scl=no

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure
" tab is not mapped by other plugin.
ino <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" : "\<TAB>"
	" \ <SID>check_back_space() ? "\<TAB>" :
	" \ coc#refresh()
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

fu! s:check_back_space() abort
	let col = col('.') - 1
	retu !col || getline('.')[col - 1]  =~# '\s'
endf

" Use <c-space> to trigger completion.
ino <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain
" at current position.
" Coc only does snippet and additional edit on confirm.
ino <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nm <silent> gd <Plug>(coc-definition)
nm <silent> gy <Plug>(coc-type-definition)
nm <silent> gi <Plug>(coc-implementation)
nm <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nn <silent> K :cal <SID>show_documentation()<CR>

fu! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		exe 'h '.expand('<cword>')
	el
		cal CocAction('doHover')
	endif
endf

" Remap for rename current word
nmap <leader>Rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f	<Plug>(coc-format-selected)
" nmap <leader>f	<Plug>(coc-format-selected)

aug mygroup
	au!
	" Setup formatexpr specified filetype(s).
	au FileType typescript,json
		\ setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
aug end

" Remap for do codeAction of selected region,
" ex: `<leader>aap` for current paragraph
xm <leader>a	<Plug>(coc-codeaction-selected)
nm <leader>a	<Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nm <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nm <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support,
" like: coc-tsserver, coc-python
nm <silent> <TAB> <Plug>(coc-range-select)
xm <silent> <TAB> <Plug>(coc-range-select)
xm <silent> <S-TAB> <Plug>(coc-range-select-backword)

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
