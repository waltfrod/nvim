return {
	{
		'SmiteshP/nvim-navic',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = false,
		priority = 1000,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"DaikyXendo/nvim-material-icon",
		},
		config = function()
			require("barbecue").setup()
		end,
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = true,
		opts = {
			ui = { border = 'double' },
		},
	},
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = function()
			local lspZero = require 'lsp-zero'
			lspZero.extend_lspconfig()
			lspZero.on_attach(function(client, bufnr)
				-- nvim-navic
				if client.server_capabilities.documentSymbolProvider then
					local navic = require 'nvim-navic'
					navic.attach(client, bufnr)
				end
				lspZero.default_keymaps {
					buffer = bufnr,
					preserve_mappings = false,
				}
			end)
			require('mason-lspconfig').setup {
				ensure_installed = { 'lua_ls', 'gopls' },
				handlers = {
					lspZero.default_setup,
				},
			}
		end,
	},
	{
		'mhartington/formatter.nvim',
		lazy = false,
		config = function()
			require('formatter').setup {
				logging = false,
				filetype = { -- Settings by File Types
					lua = require('formatter.filetypes.lua').stylua,
					go = require('formatter.filetypes.go').goimports,
					--[[
				 function()
						return {
							exe = 'golines',
							args = {
								'--base-formatter="goimports"',
							},
							stdin = true,
						}
					end,
				--]]
					javascript = require('formatter.filetypes.javascript').prettierd,
					html = require('formatter.filetypes.html').prettierd,
					css = require('formatter.filetypes.css').prettierd,
					json = require('formatter.filetypes.json').jq,
					sql = require('formatter.filetypes.sql').pgformat,
					['*'] = {
						require('formatter.filetypes.any').remove_trailing_whitespace,
					},
				},
			}
		end,
	},
}
