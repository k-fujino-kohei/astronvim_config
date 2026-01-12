return {
  "mvllow/modes.nvim",
  version = "^0.2",
  event = "VeryLazy",
  opts = function()
    return {
      line_opacity = {
        copy = 0.4,
        delete = 0.4,
        insert = 0.4,
        visual = 0.4,
      },
    }
  end,
  specs = {
    { "folke/which-key.nvim", optional = true, opts = { plugins = { presets = { operators = false } } } },
  },
}
