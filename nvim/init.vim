call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()

syntax on
colorscheme onedark

set number
set tabstop=4
set shiftwidth=4
set scrolloff=7
set ignorecase
set splitbelow splitright
set textwidth=80
set colorcolumn=+1
set cursorline cursorcolumn

hi Normal ctermbg=NONE
hi colorcolumn guibg=#0a0a0a ctermbg=232
hi CursorLine ctermbg=233
hi CursorColumn ctermbg=233

command W w

let mapleader=","

inoremap jk					<Esc>
inoremap kj					<Esc>
inoremap <C-h>				<Left>
inoremap <C-j>				<Down>
inoremap <C-k>				<Up>
inoremap <C-l>				<Right>
inoremap <leader><TAB>		<TAB>
inoremap <S-BS>				<BS>
inoremap <C-b>				<C-k>
nnoremap j					gj
nnoremap k					gk
vnoremap j					gj
vnoremap k					gk
nnoremap ;					A;<Esc>

nnoremap <silent><leader>h	:nohl<CR>
nnoremap <leader>m			:!make<CR>
nnoremap <leader>n			:!make&&./main<CR>
nnoremap <leader>r			:!"%:p"<CR>
map <F5>			:call CurtineIncSw()<CR>
nnoremap <C-n>				:NERDTreeToggle<CR>

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages
" when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure
" tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? "\<C-n>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain
" at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Remap for rename current word
nmap <leader>Rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f	<Plug>(coc-format-selected)
nmap <leader>f	<Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json
		\ setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region,
" ex: `<leader>aap` for current paragraph
xmap <leader>a	<Plug>(coc-codeaction-selected)
nmap <leader>a	<Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support,
" like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call	 CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call
	\ CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin,
" checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

autocmd BufWritePost Xresources		!xrdb "%:p"
autocmd BufRead *.kojo				set syntax=scala

autocmd BufRead *.py				set noexpandtab
autocmd BufRead *.py				set tabstop=4
autocmd BufRead *.py				set shiftwidth=4

autocmd BufWritePre *				%s/\s\+$//e
