-- save with ctrl+s
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>", { silent = true, noremap = true })

-- Move between windows using <ctrl> direction
vim.keymap.set("n", "<C-j>", "<C-W>j", { silent = true, noremap = true })
vim.keymap.set("n", "<C-k>", "<C-W>k", { silent = true, noremap = true })
vim.keymap.set("n", "<C-h>", "<C-W>h", { silent = true, noremap = true })
vim.keymap.set("n", "<C-l>", "<C-W>l", { silent = true, noremap = true })

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { silent = true, noremap = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u", { silent = true, noremap = true })
vim.keymap.set("i", ".", ".<c-g>u", { silent = true, noremap = true })
vim.keymap.set("i", ";", ";<c-g>u", { silent = true, noremap = true })

vim.keymap.set("n", "Q", "<Nop>", { silent = true, noremap = true })


-- keep selection after indent/dedent
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })

-- remove search highlight on esc
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { silent = true, noremap = true })

-- move selected text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

-- recenter screen after scrolling
vim.keymap.set("n", "<C-D>", "<C-D>M", { silent = true, noremap = true })
vim.keymap.set("n", "<C-U>", "<C-U>M", { silent = true, noremap = true })

-- find files with telescope
vim.keymap.set("n", "<c-p>", "<cmd>Telescope find_files<cr>", { silent = true, noremap = true })

-- copy/cut/paste from system clipboard
vim.keymap.set("n", "<leader>p", '"*p', { silent = true, noremap = true })
vim.keymap.set("n", "<leader>P", '"*P', { silent = true, noremap = true })
vim.keymap.set("n", "<leader>y", '"*y', { silent = true, noremap = true })
vim.keymap.set("n", "<leader>c", '"*c', { silent = true, noremap = true })
vim.keymap.set("n", "<leader>d", '"*d', { silent = true, noremap = true })

vim.keymap.set("v", "<leader>p", '"*p', { silent = true, noremap = true })
vim.keymap.set("v", "<leader>P", '"*P', { silent = true, noremap = true })
vim.keymap.set("v", "<leader>y", '"*y', { silent = true, noremap = true })
vim.keymap.set("v", "<leader>c", '"*c', { silent = true, noremap = true })
vim.keymap.set("v", "<leader>d", '"*d', { silent = true, noremap = true })

-- center after search and jumps
vim.keymap.set("n", "n", "nzz", { silent = true, noremap = true })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true, noremap = true })

-- move between splits and tabs
vim.keymap.set("n", "<c-h>", "<c-w>h", { silent = true, noremap = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { silent = true, noremap = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { silent = true, noremap = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { silent = true, noremap = true })
vim.keymap.set("n", "H", "<cmd>tabprevious<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "L", "<cmd>tabnext<cr>", { silent = true, noremap = true })

local function toggle_light_dark_theme()
	if vim.o.background == "light" then
		vim.o.background = "dark"
		vim.cmd([[Catppuccin mocha]])
	else
		vim.o.background = "light"
		vim.cmd([[Catppuccin latte]])
	end
end

vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "references", silent = true, noremap = true })
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "type definition", silent = true, noremap = true })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "diagnostics", silent = true, noremap = true })
vim.keymap.set("n", "<leader>th", toggle_light_dark_theme, { desc = "switch theme", silent = true, noremap = true })
vim.keymap.set("n", "<leader>ldd", vim.diagnostic.disable, { desc = "disable", silent = true, noremap = true })
vim.keymap.set("n", "<leader>lde", vim.diagnostic.enable, { desc = "enable", silent = true, noremap = true })

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "files", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "help", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "keymaps", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "references", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "grep", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "fuzzy", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "marks", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", { desc = "man pages", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "git commits", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "symbols", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope buffers<cr>", { desc = "buffers", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "quickfix", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "loclist", silent = true, noremap = true })
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "marks", silent = true, noremap = true })

vim.keymap.set("n", "<leader>ss", "<cmd>Telescope spell_suggest<cr>", { desc = "spelling", silent = true, noremap = true })
vim.keymap.set("n", "<leader>s/", "<cmd>setlocal spell!<cr>", { desc = "spelling on", silent = true, noremap = true })

vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "fugitive", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gs", ":Gitsigns<cr>", { desc = "gitsigns", silent = true, noremap = true })

vim.keymap.set("n", "<leader>xx", ":w<cr>:source %<cr>", { desc = "file", silent = true, noremap = true })
vim.keymap.set("n", "<c-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "go to definition", silent = true, noremap = true })
vim.keymap.set("n", "<c-q>", "<cmd>q<cr>", { desc = "close buffer", silent = true, noremap = true })
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { desc = "remove search highlight", silent = true, noremap = true })
vim.keymap.set("n", "gf", ":e <cfile><CR>", { desc = "edit file", silent = true, noremap = true })
vim.keymap.set("n", "]q", ":silent cnext<cr>", { desc = "quickfix next", silent = true, noremap = true })
vim.keymap.set("n", "[q", ":silent cprev<cr>", { desc = "quickfix prev", silent = true, noremap = true })


vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { desc = "move line down", silent = true, noremap = true })
vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = "move line up", silent = true, noremap = true })

vim.keymap.set("i", "<c-x><c-x>", "<c-x><c-o>", { desc = "omnifunc completion", silent = true, noremap = true })
