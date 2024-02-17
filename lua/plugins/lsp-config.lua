return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "ruff_lsp" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local function lsp_format_on_save()
        vim.cmd([[
          augroup LspAutocmds
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
          augroup END
        ]])
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          lsp_format_on_save()
        end,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client)
          lsp_format_on_save()
        end,
      })
      lspconfig.ruff_lsp.setup({
        capabilities = capabilities,
        on_attach = function(client)
          lsp_format_on_save()
        end,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
