return {
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require("mini.surround").setup()
    end
  },
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require("mini.ai").setup()
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          winblend = 0,
          border = "none",
        },
      },
    },
  }
}
