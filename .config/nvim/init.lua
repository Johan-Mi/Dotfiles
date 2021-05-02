local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

local function tc(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmd [[packadd paq-nvim]]
local paq = require'paq-nvim'.paq
paq { 'savq/paq-nvim', opt = true }

paq 'neovim/nvim-lspconfig'
paq 'hrsh7th/nvim-compe'
paq 'tpope/vim-commentary'
paq 'joshdick/onedark.vim'
paq 'sbdchd/neoformat'
paq 'cespare/vim-toml'
paq 'ron-rs/ron.vim'
paq 'windwp/nvim-autopairs'

vim.o.completeopt = 'menuone,noselect'

require'compe'.setup {
    preselect = 'always',
    source = { path = true, buffer = true, nvim_lsp = true, nvim_lua = true },
}

local npairs = require 'nvim-autopairs'
npairs.setup {}

vim.g.neoformat_basic_format_retab = 0

local lspconfig = require 'lspconfig'
lspconfig.rust_analyzer.setup {}

cmd [[syntax on]]
cmd [[colorscheme onedark]]
vim.o.termguicolors = true

vim.o.statusline =
    [[ %<%1*%f%* %h%m%3*%{&readonly?'':''}%* %3l:%-2v %P%=%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}   %2*%{&ft}%* ]]
vim.api.nvim_exec([[
highlight User1 guibg=#0b0b0b gui=bold
highlight User2 guifg=#61afef guibg=#0b0b0b gui=bold
highlight User3 guifg=#d19a66 guibg=#0b0b0b
]], false)

vim.o.number = true
vim.o.relativenumber = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.o.scrolloff = 7
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.textwidth = 80
vim.bo.textwidth = 80
vim.o.colorcolumn = '+1'
vim.wo.colorcolumn = '+1'
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
vim.o.list = true
vim.wo.list = true
vim.o.listchars = 'tab:¦ '
vim.wo.listchars = 'tab:¦ '
vim.o.formatoptions = string.gsub(vim.o.formatoptions, 't', '')
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true

vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.shortmess = vim.o.shortmess .. 'cI'
vim.o.signcolumn = 'no'
vim.wo.signcolumn = 'no'

vim.api.nvim_exec([[
highlight colorcolumn ctermbg=232 guibg=#080808
highlight CursorLine ctermbg=233 guibg=#0e0e0e
highlight CursorColumn ctermbg=233 guibg=#0e0e0e
highlight CursorLineNr ctermbg=233 guibg=#0e0e0e
highlight WhiteSpace ctermfg=234 guifg=#303030
highlight StatusLine guibg=#0b0b0b
highlight Pmenu guibg=#202020
]], false)

vim.g.mapleader = ' '

map('', '<Space>', '', { noremap = true })
map('i', 'jk', '<Esc>', { noremap = true })
map('i', 'kj', '<Esc>', { noremap = true })
map('n', '<C-h>', '<C-w>h', { noremap = true })
map('n', '<C-j>', '<C-w>j', { noremap = true })
map('n', '<C-k>', '<C-w>k', { noremap = true })
map('n', '<C-l>', '<C-w>l', { noremap = true })
map('i', '<C-h>', '<BS>', { noremap = true })
map('i', '<C-b>', '<C-k>', { noremap = true })
map('n', ';', 'm`A;<Esc>``', { noremap = true, silent = true })
map('n', '!', ':!', { noremap = true })
map('n', '§', '@:', { noremap = true })
map('n', 'g<', '<cmd>tabmove -<CR>', { noremap = true })
map('n', 'g>', '<cmd>tabmove +<CR>', { noremap = true })
map('n', '<Tab>', 'gt', { noremap = true })
map('n', '<S-Tab>', 'gT', { noremap = true })

map('n', '<Leader>fs', '<cmd>update<CR>', { noremap = true })
map('n', '<Leader>cc', '<cmd>!make<CR>', { noremap = true })
map('n', '<Leader>cl', '<cmd>!make clean<CR>', { noremap = true, silent = true })
map('n', '<Leader>n', '<cmd>call v:lua.compile_and_run()<CR>',
    { noremap = true })
map('n', '<Leader>d', '<cmd>Lexplore<CR>', { noremap = true })
map('n', '<Leader>r', '<cmd>!"%:p"<CR>', { noremap = true })
map('n', '<Leader>qq', '<cmd>xa<CR>', { noremap = true })
map('n', '<Leader>qQ', '<cmd>qa!<CR>', { noremap = true })
map('n', '<Leader>cf', '<cmd>Neoformat<CR>', { noremap = true })
    { noremap = true, silent = true })
map('n', '<Leader>t', ':tabedit ', { noremap = true })
map('n', '<Leader>e', ':edit ', { noremap = true })
map('n', '<Leader>gg', '<cmd>execute "!git grep" expand("<cword>")<cr>',
    { noremap = true })
map('n', '<Leader>uw', 'dwf>xF<x', { noremap = true })
map('n', '<Leader>uW', 'dwf>xF<r&', { noremap = true })
map('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>',
    { noremap = true, silent = true })
map('n', '<Leader>l', '<cmd>!cargo clippy<CR>', { noremap = true })
map('i', '<C-Space>', 'compe#complete()',
    { noremap = true, silent = true, expr = true })
map('i', '<CR>', 'v:lua.completion_confirm()', { noremap = true, expr = true })
map('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>',
    { noremap = true, silent = true })
map('n', '<Leader>cD', '<cmd>lua vim.lsp.buf.references()<CR>',
    { noremap = true, silent = true })
map('n', '<Leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    { noremap = true, silent = true })
map('n', 'K', '<cmd>call v:lua.show_documentation()<CR>',
    { noremap = true, silent = true })
map('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>',
    { noremap = true, silent = true })
map('', '<Space><Space>', ':', { noremap = true })
map('i', '<Tab>', tc 'pumvisible() ? "<C-n>" : "<Tab>"',
    { noremap = true, expr = true })
map('i', '<S-Tab>', tc 'pumvisible() ? "<C-p>" : "<C-h>"',
    { noremap = true, expr = true })

vim.api.nvim_exec([[
autocmd BufWritePost Xresources	!xrdb "%:p"
autocmd BufRead *.py			set expandtab tabstop=4 shiftwidth=4
autocmd BufRead *.json			set tabstop=2
autocmd BufRead *.scratch		setf python | set tabstop=4 shiftwidth=4
autocmd BufWritePre *.rs,*.lua	Neoformat
]], false)

function _G.show_documentation()
    if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        cmd('help ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

function _G.compile_and_run()
    cmd [[silent !cargo locate-project]]
    if vim.v.shell_error == 0 then
        cmd [[!cargo run]]
    else
        cmd [[!make&&./main]]
    end
end

function _G.completion_confirm()
    return vim.fn['compe#confirm'](npairs.check_break_line_char())
end
