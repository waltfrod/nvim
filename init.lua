-- Lazy.nvim Setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- OPTION SETTINGS ------------------------------------------------------------
vim.g.mapleader = " "       -- Set <space> as the leader key
vim.g.maplocalleader = "\\"
vim.o.hlsearch = true    -- Set highlight on search
vim.wo.number = true   -- Make line numbers default
vim.o.mouse = "a"    -- Enable mouse mode
vim.o.breakindent = true    -- Enable break indent
vim.o.undofile = true    -- Save undo history
vim.o.ignorecase = true    -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
-- Tab 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.wo.signcolumn = "yes"    -- Keep signcolumn on by)
keymap("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

-- Paste
keymap("", "]p", "o<Esc>p", { desc = "Paste below" })
keymap("n", "]P", "O<Esc>p", { desc = "Paste above" })

-- Better escape
keymap("n", "<Esc>", "<cmd>nohl<CR>", { desc = "ESC in normal mode" })
keymap("i", "<C-]>", "<ESC>", { desc = "Alternate escape" })
keymap("t", "<C-]>", "<C-\\><C-n>", { desc = "Escape in terminal mode" })

-- Movimientos Dvorak
-- Normal Mode
keymap("n", "<M-r>", "h")
keymap("n", "<M-t>", "j")
keymap("n", "<M-n>", "k")
keymap("n", "<M-s>", "l")
-- Visual Mode
keymap("x", "<M-r>", "h")
keymap("x", "<M-t>", "j")
keymap("x", "<M-n>", "k")
keymap("x", "<M-s>", "l")
-- Insert Mode
keymap("i", "<M-r>", "<Left>")
keymap("i", "<M-t>", "<Down>")
keymap("i", "<M-n>", "<Up>")
keymap("i", "<M-s>", "<Right>")
-- Terminal mode
keymap("t", "<C-r>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-t>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-n>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-s>", "<C-\\><C-n><C-w>l")
-- Movements between buffers - (Dvorak latam)
keymap("n", "<C-r>", "<C-w>h")
keymap("n", "<C-t>", "<C-w>j")
keymap("n", "<C-n>", "<C-w>k")
keymap("n", "<C-s>", "<C-w>l")

-- Buffer
keymap("n", "<C-h>", "<cmd>bp<CR>", { desc = "Next buffer" })
keymap("n", "<C-l>", "<cmd>bn<CR>", { desc = "Prev buffer" })
keymap("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- Identación
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Pegar sobre el texto actualmente seleccionado sin copiarlo
keymap("v", "p", '"_dp')
keymap("v", "P", '"_dP')
-- Copiar desde el cursor hasta el final de línea
keymap("n", "Y", "y$")
-- X clipboard
keymap("x", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from Clipboard" })
keymap("n", "<leader>P", '"+P', { desc = "Paste before from Clipboard" })

-- Insertar líneas en blanco
keymap("n", "<Space>]", "o<Esc>", { desc = "Insert line next" })
keymap("n", "<Space>[", "O<Esc>", { desc = "Insert line prev" })

-- Auto indent
keymap("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })


-- AUTOCOMMAND ----------------------------------------------------------------
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = augroup("highlight_yank"),
	pattern = "*",
})

-- Alternar automáticamente entre números de línea relativos y absolutos
-- Los números relativos se utilizan en un búfer que tiene el foco y está en modo normal, ya que es ahí donde te
-- mueves.
-- Se desactivan cuando sales de Vim, cambias a otra división o entra en los modos de inserción y comando.
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
})

local is_int = function(n)
	return (type(n) == "number") and (math.floor(n) == n)
end

-- Ubicar el cursor es la última posición
local lastEdited = vim.api.nvim_create_augroup("lastEdited", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	group = lastEdited,
	callback = function()
		pos = vim.fn.line(".")
		fin = vim.fn.line("$")
		if is_int(pos) and is_int(fin) and pos > 0 and pos <= fin then
			vim.cmd([[normal! g`"]])
		end
	end,
})

-- No comentar nuevas líneas
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])


-- LAZYNVIM SETUP -------------------------------------------------------------

require("lazy").setup({
	spec = {
		{import = 'pde'}
	},
	ui = { border = "double" },
	defaults = { lazy = true, version = nil },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

