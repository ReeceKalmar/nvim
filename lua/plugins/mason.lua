return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({ automatic_installation = true })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.texlab.setup({})
            lspconfig.omnisharp.setup({
                cmd = { "dotnet", "/home/reece311/.config/omnisharp/OmniSharp.dll" },
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = nil,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = nil,
                    },
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = nil,
                        EnableImportCompletion = nil,
                        AnalyzeOpenDocumentsOnly = nil,
                    },
                    Sdk = {
                        IncludePrereleases = true,
                    },
                },
                handler = {
                    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
                    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
                    ["textDocument/references"] = require("omnisharp_extended").references_handler,
                    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
                },
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
        end,
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
    },
}
