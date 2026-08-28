return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
		preset = "helix",
		win = {
			title = false,
			border = "none",
			padding = {0, 1},
		},
		icons = {
			breadcrumb = ">>=",
			separator = ":: ",
			group = " ++ ",
			keys = {},
		},
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
