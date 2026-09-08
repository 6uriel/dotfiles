return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "marksman",
        "tinymist",
        "pyright",
        "bashls",
        "clangd",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      vim.lsp.config("tinymist", {
        settings = { formatterMode = "typstyle" },
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })
      vim.lsp.config("marksman", {})
    end,
  },
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()
      metals_config.settings = {
        serverVersion = "1.6.8",
        showImplicitArguments = true,
        testUserInterface = "Test Explorer",
      }
      metals_config.init_options.statusBarProvider = "off"
      metals_config.on_attach = function()
        require("lazy").load({ plugins = { "nvim-dap" } })
        require("metals").setup_dap()
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  }
}
