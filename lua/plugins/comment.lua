return {
    'numToStr/Comment.nvim',
    opts = {
      keys = {
        n = 'gc',
        v = 'gc',
      },
    },
    lazy = false,
    setup = function()
      require('Comment').setup()
    end,
}
