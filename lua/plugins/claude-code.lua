local prefix = "<Leader>z"
return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings.n[prefix] = { desc = " Claude" }

        local maps = assert(opts.mappings)
        local astroui = require "astroui"
        maps.n[prefix] = { desc = astroui.get_icon("ClaudeCode", 1, true) .. "ClaudeCode" }

        maps.n[prefix .. "z"] = { ":ClaudeCode<CR>", desc = "Toggle Claude Code" }
        maps.n[prefix .. "c"] = { ":ClaudeCodeContinue<CR>", desc = "Claude Code Continue" }
        maps.n[prefix .. "v"] = { ":ClaudeCodeVerbose<CR>", desc = "Claude Code Verbose" }
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { ClaudeCode = "" } } },
  },
  config = function() require("claude-code").setup() end,
  specs = {},
  opts = function(opts)
    opts.window = {
      split_ratio = 0.3, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
      position = "vertival", -- Position of the window: "botright", "topleft", "vertical", "rightbelow vsplit", etc.
      enter_insert = true, -- Whether to enter insert mode when opening Claude Code
      hide_numbers = true, -- Hide line numbers in the terminal window
      hide_signcolumn = true, -- Hide the sign column in the terminal window
    }
  end,
}
