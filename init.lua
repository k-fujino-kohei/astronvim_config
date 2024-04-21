-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.keymap.set("n", ";", ":")
vim.keymap.set("i", "jj", "<ESC>")
vim.opt.swapfile = false
vim.opt.whichwrap = "h,l,<,>,[,]" --  行頭・行末から左右移動で前・次行に移動する
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

-- https://neovim.discourse.group/t/how-can-i-setup-eslint-to-format-on-save/2570/5
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  -- command = 'silent! EslintFixAll',
  callback = function() vim.api.nvim_exec("silent! EslintFixAll", true) end,
})
