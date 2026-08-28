-- telescope.nvim
return {
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "jvgrootveld/telescope-zoxide"
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {

          border = {
            prompt = { 1, 1, 1, 1 },
            results = { 1, 1, 1, 1 },
            preview = { 1, 1, 1, 1 },
          },
          borderchars = {
            prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
            results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
            preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--glob",
              "!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}",
              "--path-separator",
              "/",
            },
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("zoxide")

      -- require("telescope").extensions.metals.commands()

      -- telescope setup
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>j", "<Cmd>:Telescope zoxide list<CR>", { desc = "Telescope zoxide" })
      vim.keymap.set("n", "<leader>si", builtin.grep_string, { desc = "Telescope grep string" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope diagnostics" })
      vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Telescope oldfiles" })
      vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "Telescope references" })
      vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })
      vim.keymap.set("n", "<leader>sw", builtin.lsp_workspace_symbols, { desc = "Telescope workspace symbols" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "Telescope man pages" })
      vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "Telescope builtins" })

    end,
  },
}
