return {
	{
		"OmniSharp/omnisharp-vim",
		dependencies = { "dense-analysis/ale" },
		config = function()
			-- Set complete options
			vim.opt.completeopt = "longest,menuone,preview"
			vim.opt.previewheight = 5

			-- Set ALE linters for C#
			vim.g.ale_linters = { cs = { "OmniSharp" } }
			vim.g.ale_fix_on_save = 1

			-- Autocommands for OmniSharp functionality
			vim.api.nvim_create_augroup("omnisharp_commands", { clear = true })

			vim.api.nvim_create_autocmd("CursorHold", {
				group = "omnisharp_commands",
				pattern = "*.cs",
				command = "OmniSharpTypeLookup",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = "omnisharp_commands",
				pattern = "cs",
				callback = function()
					local keymap_opts = { noremap = true, silent = true, buffer = true }
					vim.api.nvim_set_keymap("n", "gd", "<Plug>(omnisharp_go_to_definition)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osfu", "<Plug>(omnisharp_find_usages)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osfi", "<Plug>(omnisharp_find_implementations)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>ospd", "<Plug>(omnisharp_preview_definition)", keymap_opts)
					vim.api.nvim_set_keymap(
						"n",
						"<Leader>ospi",
						"<Plug>(omnisharp_preview_implementations)",
						keymap_opts
					)
					vim.api.nvim_set_keymap("n", "<Leader>ost", "<Plug>(omnisharp_type_lookup)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>os=", "<Plug>(omnisharp_code_format)", keymap_opts) -- Format
					vim.api.nvim_set_keymap("n", "<Leader>osd", "<Plug>(omnisharp_documentation)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osfs", "<Plug>(omnisharp_find_symbol)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osfx", "<Plug>(omnisharp_fix_usings)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<C-\\>", "<Plug>(omnisharp_signature_help)", keymap_opts)
					vim.api.nvim_set_keymap("i", "<C-\\>", "<Plug>(omnisharp_signature_help)", keymap_opts)
					vim.api.nvim_set_keymap("n", "[[", "<Plug>(omnisharp_navigate_up)", keymap_opts)
					vim.api.nvim_set_keymap("n", "]]", "<Plug>(omnisharp_navigate_down)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osgcc", "<Plug>(omnisharp_global_code_check)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osca", "<Plug>(omnisharp_code_actions)", keymap_opts)
					vim.api.nvim_set_keymap("x", "<Leader>osca", "<Plug>(omnisharp_code_actions)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>os.", "<Plug>(omnisharp_code_action_repeat)", keymap_opts)
					vim.api.nvim_set_keymap("x", "<Leader>os.", "<Plug>(omnisharp_code_action_repeat)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>os=", "<Plug>(omnisharp_code_format)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osnm", "<Plug>(omnisharp_rename)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osre", "<Plug>(omnisharp_restart_server)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>osst", "<Plug>(omnisharp_start_server)", keymap_opts)
					vim.api.nvim_set_keymap("n", "<Leader>ossp", "<Plug>(omnisharp_stop_server)", keymap_opts)
				end,
			})
		end,
	},
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		init = function()
			local config = {
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").definition_handler,
					["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
					["textDocument/references"] = require("omnisharp_extended").references_handler,
					["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
				},
			}
			-- Set up key mappings inside init
			vim.api.nvim_set_keymap(
				"n",
				"gr",
				"<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"gd",
				"<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })<cr>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>D",
				"<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"gi",
				"<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>",
				{ noremap = true, silent = true }
			)

			require("lspconfig").omnisharp.setup(config)
		end,
	},
}
