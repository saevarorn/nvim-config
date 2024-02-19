return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'kevinhwang91/promise-async',
  },
  config = function()
    local ufo = require('ufo')
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })

    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)
  end,
}
