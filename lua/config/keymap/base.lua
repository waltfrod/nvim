local nvmap = vim.keymap.set
local M = {}

-- General maps
function M.setup()
	nvmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
	-- Better viewing
	nvmap("n", "n", "nzzzv")
	nvmap("n", "N", "Nzzzv")
	nvmap("n", "g,", "g,zvzz")
	nvmap("n", "g;", "g;zvzz")
	-- Scrolling
	nvmap("n", "<C-d>", "<C-d>zz")
	nvmap("n", "<C-u>", "<C-u>zz")
	-- Save / Quit
	nvmap("n", "<leader><leader>w", "<cmd>w!<CR>", { desc = "Save buffer" })
	nvmap("n", "<leader><leader>W", "<cmd>wall!<CR>", { desc = "Save all buffers" })
	nvmap("n", "<leader><leader>q", "<cmd>q!<CR>", { desc = "Quit buffer" })
	nvmap("n", "<leader><leader>Q", "<cmd>qall!<CR>", { desc = "Quit all buffers" })
	nvmap("n", "<leader><leader>x", "<cmd>x!<CR>", { desc = "Save & quit buffer" })
	nvmap("n", "<leader><leader>X", "<cmd>xall!<CR>", { desc = "Save & quit all buffers" })
	-- Mejor visualización en la búsqueda
	nvmap("n", "n", "nzzzv", { desc = "Search next and Center" })
	nvmap("n", "N", "Nzzzv", { desc = "Search prev and Center" })
	nvmap("n", "g,", "g,zvzz", { desc = "Next pos in jumplist" })
	nvmap("n", "g;", "g;zvzz", { desc = "Prev pos in jumplist" })
	-- Mejor desplazamiento
	nvmap("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
	nvmap("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
	-- Better escape
	nvmap("n", "<Esc>", "<cmd>nohl<CR>", { desc = "ESC in normal mode" })
	nvmap({ "i", "x", "n" }, "<C-]>", "<ESC>", { desc = "Alternate escape" })
	nvmap("t", "<C-]>", "<C-\\><C-n>", { desc = "Escape in terminal mode" })
	-- Movimientos Dvorak
	-- Normal Mode
	nvmap("n", "<M-r>", "h")
	nvmap("n", "<M-t>", "j")
	nvmap("n", "<M-n>", "k")
	nvmap("n", "<M-s>", "l")
	-- Visual Mode
	nvmap("x", "<M-r>", "h")
	nvmap("x", "<M-t>", "j")
	nvmap("x", "<M-n>", "k")
	nvmap("x", "<M-s>", "l")
	-- Insert Mode
	nvmap("i", "<M-r>", "<Left>")
	nvmap("i", "<M-t>", "<Down>")
	nvmap("i", "<M-n>", "<Up>")
	nvmap("i", "<M-s>", "<Right>")
	-- Terminal mode
	nvmap("t", "<C-r>", "<C-\\><C-n><C-w>h")
	nvmap("t", "<C-t>", "<C-\\><C-n><C-w>j")
	nvmap("t", "<C-n>", "<C-\\><C-n><C-w>k")
	nvmap("t", "<C-s>", "<C-\\><C-n><C-w>l")
	-- Movimientos entre buffers - (Dvorak latam)
	nvmap("n", "<C-r>", "<C-w>h", { desc = "Go left buffer" })
	nvmap("n", "<C-t>", "<C-w>j", { desc = "Go upper buffer" })
	nvmap("n", "<C-n>", "<C-w>k", { desc = "Go lower buffer" })
	nvmap("n", "<C-s>", "<C-w>l", { desc = "Go right buffer" })
	-- Buffer
	nvmap("n", "<C-h>", "<cmd>bp<CR>", { desc = "Next buffer" })
	nvmap("n", "<C-l>", "<cmd>bn<CR>", { desc = "Prev buffer" })
	nvmap("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
	-- Identación
	nvmap("v", "<", "<gv")
	nvmap("v", ">", ">gv")
	-- Pegar sobre el texto actualmente seleccionado sin copiarlo
	nvmap("v", "p", '"_dP')
	-- Copiar desde el cursor hasta el final de línea
	nvmap("n", "Y", "y$")
	-- X clipboard
	nvmap("x", "<leader>y", '"+y', { desc = "Copy to Clipboard" })
	nvmap("n", "<leader>p", '"+p', { desc = "Paste from Clipboard" })
	nvmap("n", "<leader>P", '"+P', { desc = "Paste before from Clipboard" })
	-- Insertar líneas en blanco
	nvmap("n", "<leader>]", "o<Esc>", { desc = "Insert line next" })
	nvmap("n", "<leader>[", "O<Esc>", { desc = "Insert line prev" })
	-- Undo/Redo
	nvmap("n", "<leader>(", ":undo<CR>", { desc = "Undo action" })
	nvmap("n", "<leader>)", ":redo<CR>", { desc = "Redo action" })
end

return M
