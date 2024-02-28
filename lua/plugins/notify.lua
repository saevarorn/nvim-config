return {
  "rcarriga/nvim-notify",
  config = function()
    require("telescope").load_extension("notify")
    local notify = require("notify")

    notify.setup({
      stages = "fade",
      timeout = 3000,
      background_colour = "#1e222a",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    vim.notify = function(msg, log_level, _)
      if log_level == vim.log.levels.ERROR then
        notify(msg, "error", { title = "Error" })
      elseif log_level == vim.log.levels.WARN then
        notify(msg, "warn", { title = "Warning" })
      elseif log_level == vim.log.levels.INFO then
        notify(msg, "info", { title = "Info" })
      elseif log_level == vim.log.levels.DEBUG then
        notify(msg, "debug", { title = "Debug" })
      elseif log_level == vim.log.levels.TRACE then
        notify(msg, "trace", { title = "Trace" })
      end
    end
  end,
}
