local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
local opt = vim.opt

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

opt.completeopt = 'menuone,noselect'

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
opt.termguicolors = true

opt.statusline =
    [[ %<%1*%f%* %h%m%3*%{&readonly?'':''}%* %3l:%-2v %P%=%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}   %2*%{&ft}%* ]]
vim.api.nvim_exec([[
highlight User1 guibg=#0b0b0b gui=bold
highlight User2 guifg=#61afef guibg=#0b0b0b gui=bold
highlight User3 guifg=#d19a66 guibg=#0b0b0b
]], false)

vim.g.leave_my_cursor_position_alone = true
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 7
opt.smartcase = true
opt.hlsearch = false
opt.splitbelow = true
opt.splitright = true
opt.textwidth = 80
opt.colorcolumn = '+1'
opt.cursorline = true
opt.cursorcolumn = true
opt.list = true
opt.listchars = 'tab:¦ '
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.shortmess:append 'cI'
opt.signcolumn = 'no'
opt.inccommand = 'nosplit'

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
autocmd BufWritePre *.rs,*.lua	Neoformat
autocmd BufWritePost *.tex	    !pdflatex "%:p"
autocmd FileType tex inoremap <buffer><expr><space> strpart(getline('.'), col('.') - 1, 1) == '{' ? "\<Right>" : "\<Space>"
]], false)

function _G.show_documentation()
    local filetype = opt.filetype:get()
    if filetype == 'vim' or filetype == 'help' then
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
