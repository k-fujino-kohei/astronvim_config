-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.remote-development.remote-sshfs-nvim" },
  -- { import = "astrocommunity.editing-support.yanky-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
}
