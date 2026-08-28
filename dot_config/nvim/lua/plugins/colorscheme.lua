return {
  -- themes
	{ "RRethy/base16-nvim" },
	{ "vague-theme/vague.nvim" },

  -- other
	{ "typicode/bg.nvim", lazy = false },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
      })
    end,
  },
}
