require("mufeedcm.core")
require("mufeedcm.lazy")

-- Add the ftplugin directory to runtime path
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/mufeedcm/")

--mode line ':help modline'
-- vim: ts=2 sts=2 sw=2 et
