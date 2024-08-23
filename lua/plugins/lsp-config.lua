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
        ensure_installed = { "lua_ls", "tsserver" },
        -- ensure_installed = { "lua_ls", "tsserver", "ruff_lsp" },
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

      -- lspconfig.ruff_lsp.setup({
      --   capabilities = capabilities,
      --   on_attach = function(client)
      --     vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      --       pattern = "*.py",
      --       group = vim.api.nvim_create_augroup("RuffAutoFix", { clear = true }),
      --       callback = function(ev)
      --         vim.lsp.buf.code_action({
      --           filter = function(action)
      --             return action.title == "Ruff: Fix All"
      --           end,
      --           apply = true,
      --         })
      --       end,
      --     })
      --     lsp_format_on_save()
      --   end,
      -- })

      lspconfig.jsonls.setup({
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
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        ensure_installed = { "stylua" },
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.mypy.with({
            condition = function(utils)
              return utils.root_has_file("pyproject.toml")
            end,
            command = function()
              local virtual_env = os.getenv("VIRTUAL_ENV")

              if virtual_env then
                return virtual_env .. "/bin/mypy"
              end

              return "mypy"
            end,
            args = function(params)
              return {
                "--hide-error-codes",
                "--hide-error-context",
                "--no-color-output",
                "--show-absolute-path",
                "--show-column-numbers",
                "--show-error-codes",
                "--no-error-summary",
                "--no-pretty",
                "--shadow-file",
                params.bufname,
                params.temp_path,
                params.bufname,
              }
            end,
          }),
        },
      })

      -- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "mypy" },
      })
    end,
  },
}
