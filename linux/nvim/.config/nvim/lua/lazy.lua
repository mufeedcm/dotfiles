package.loaded["lazy"] = nil
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  error("Failed to load lazy.nvim:\n" .. lazy)
end

lazy.setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lspconfig" }, 
  },
  change_detection = {
    notify = false,
  },
})
