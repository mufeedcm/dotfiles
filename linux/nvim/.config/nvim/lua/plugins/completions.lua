-- Autocompletion
return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    -- Snippet Engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      opts = {
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        update_events = "TextChanged,TextChangedI",
      },
      config = function(_, opts)
        local luasnip = require("luasnip")
        luasnip.config.setup(opts)

        -- load vscode-style snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        -- load your custom lua snippets
        require("luasnip.loaders.from_lua").load({
          paths = { "~/.config/nvim/lua/plugins/LuaSnip/" },
        })

        vim.keymap.set({ "i", "s" }, "jk", function()
          return luasnip.jump(1) and "<Plug>luasnip-jump-next" or "jk"
        end, { expr = true, silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
          return luasnip.jump(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
        end, { expr = true, silent = true })

        vim.keymap.set({ "i", "s" }, "<C-j>", function()
          return luasnip.choice_active() and "<Plug>luasnip-next-choice" or "<C-j>"
        end, { expr = true, silent = true })
      end,
    },
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for <c-y> to accept ([y]es) the completion.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      preset = "default",
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      -- default = { "lsp", "path", "snippets", "buffer", "lazydev", "tailwind" },
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        -- tailwind = {
          -- 	module = "tailwindcss-colorizer-cmp.blink",
          -- 	score_offset = 1000,
          -- 	opts = {
            -- 		get_filetype = function()
              -- 			local allowed = {
                -- 				"html",
                -- 				"css",
                -- 				"javascript",
                -- 				"javascriptreact",
                -- 				"typescriptreact",
                -- 			}
                -- 			local ft = vim.bo.filetype
                -- 			return vim.tbl_contains(allowed, ft) and ft or nil
                -- 		end,
                -- 	},
                -- },
              },
            },

            snippets = { preset = "luasnip" },

            fuzzy = { implementation = "lua" },
            signature = { enabled = true },
          },
        }
