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

local map_n = { noremap = true }
local map_ns = { noremap = true, silent = true }
local map_ne = { noremap = true, expr = true }
local map_nse = { noremap = true, silent = true, expr = true }

map('', '<Space>', '', map_n)
map('i', 'jk', '<Esc>', map_n)
map('i', 'kj', '<Esc>', map_n)
map('n', '<C-h>', '<C-w>h', map_n)
map('n', '<C-j>', '<C-w>j', map_n)
map('n', '<C-k>', '<C-w>k', map_n)
map('n', '<C-l>', '<C-w>l', map_n)
map('i', '<C-h>', '<BS>', map_n)
map('i', '<C-b>', '<C-k>', map_n)
map('n', ';', 'm`A;<Esc>``', map_ns)
map('n', '!', ':!', map_n)
map('n', '§', '@:', map_n)
map('n', 'g<', '<cmd>tabmove -<CR>', map_n)
map('n', 'g>', '<cmd>tabmove +<CR>', map_n)
map('n', '<Tab>', 'gt', map_n)
map('n', '<S-Tab>', 'gT', map_n)

map('n', '<Leader>fs', '<cmd>update<CR>', map_n)
map('n', '<Leader>cc', '<cmd>!make<CR>', map_n)
map('n', '<Leader>cl', '<cmd>!make clean<CR>', map_ns)
map('n', '<Leader>n', '<cmd>call v:lua.compile_and_run()<CR>', map_n)
map('n', '<Leader>d', '<cmd>Lexplore<CR>', map_n)
map('n', '<Leader>r', '<cmd>!"%:p"<CR>', map_n)
map('n', '<Leader>qq', '<cmd>xa<CR>', map_n)
map('n', '<Leader>qQ', '<cmd>qa!<CR>', map_n)
map('n', '<Leader>cf', '<cmd>Neoformat<CR>', map_n)
map('n', '<Leader>t', ':tabedit ', map_n)
map('n', '<Leader>e', ':edit ', map_n)
map('n', '<Leader>gg', '<cmd>execute "!git grep" expand("<cword>")<cr>', map_n)
map('n', '<Leader>uw', 'dwf>xF<x', map_n)
map('n', '<Leader>uW', 'dwf>xF<r&', map_n)
map('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_ns)
map('n', '<Leader>l', '<cmd>!cargo clippy<CR>', map_n)
map('i', '<C-Space>', 'compe#complete()', map_nse)
map('i', '<CR>', 'v:lua.completion_confirm()', map_ne)
map('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_ns)
map('n', '<Leader>cD', '<cmd>lua vim.lsp.buf.references()<CR>', map_ns)
map('n', '<Leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_ns)
map('n', 'K', '<cmd>call v:lua.show_documentation()<CR>', map_ns)
map('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', map_ns)
map('', '<Space><Space>', ':', map_n)
map('i', '<Tab>', tc 'pumvisible() ? "<C-n>" : "<Tab>"', map_ne)
map('i', '<S-Tab>', tc 'pumvisible() ? "<C-p>" : "<C-h>"', map_ne)

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
