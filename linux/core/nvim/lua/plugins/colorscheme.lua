-- Color Scheme setup
return {
-- {
--   "gambhirsharma/vesper.nvim",
--   lazy = false,
--   priority = 1000,
--   name = "vesper",
--   config = function ()
--    vim.cmd([[colorscheme vesper]])
--   end
-- },
--
-- {
--   "oskarnurm/koda.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     -- require("koda").setup({ transparent = true })
--     vim.cmd("colorscheme koda")
--   end,
-- },
{
  "darianmorat/gruvdark.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    colors = {
      colors = {
        bg0 = "#161413",
        bg1 = "#1A1817",
        bg2 = "#211E1C",
        bg3 = "#262220",
      },
    },
    highlights = {
      Normal       = { bg = "#161413" },
      NormalNC     = { bg = "#161413" },
      NormalFloat  = { bg = "#1A1817" },
      SignColumn   = { bg = "#161413" },
      EndOfBuffer  = { fg = "#161413" },
      CursorLine   = { bg = "#1E1B19" },
      Visual       = { bg = "#2A2624" },
    },
  },
  config = function(_, opts)
    require("gruvdark").setup(opts)
    vim.cmd.colorscheme("gruvdark")
    vim.o.background = "dark"
  end,
},

-- {
  -- 	"ellisonleao/gruvbox.nvim",
  -- 	enabled = true,
  -- 	priority = 1000,
  -- 	opts = {
    -- 		contrast = "hard", -- optional, for more punchy colors
    -- 		transparent_mode = false,
    -- 	},
    -- 	config = function()
      -- 		vim.o.background = "dark"
      -- 		vim.cmd.colorscheme("gruvbox")
      --
      -- 		-- Set background to pure black
      -- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
      -- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
      -- 	end,
      -- },

      -- {
        -- 	-- tokyonight with bg black
        -- 	"folke/tokyonight.nvim",
        -- 	priority = 1000,
        -- 	init = function()
          -- 		vim.cmd.colorscheme("tokyonight-night")
          --
          -- 		-- Make background pure black
          -- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
          -- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" }) -- Inactive windows too
          -- 		vim.api.nvim_set_hl(0, "Comment", { italic = false }) -- You already did this but now using modern style
          -- 	end,
          -- },
        }
