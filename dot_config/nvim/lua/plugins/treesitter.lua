return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {}

    local parsers = {
      'lua', 'vim', 'vimdoc',
      'c', 'cpp',
      'python',
      'bash',
      'markdown', 'markdown_inline',
      'typst',
      'scala',
      'json', 'yaml', 'toml',
      'gitcommit', 'gitignore',
      'regex',
      'query',
    }

    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
