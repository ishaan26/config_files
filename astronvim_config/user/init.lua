return {

  -- Custom Colorshcheme. Configured in the onedark file in the plugins folder.
  colorscheme = "onedark_dark",

  -- Global lsp setting. This is so much easier that setting up mannually. wow.
  lsp = {
    formatting = {
      -- enable or disable automatic formatting on save
      format_on_save = true,
    },

    setup_handlers = {
      -- add custom handler for rust tools
      rust_analyzer = function(_, opts)
        require("rust-tools").setup({
          server = opts,
        })
      end,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      tabstop = 4,
      shiftwidth = 4,
      expandtab = true,
      smartindent = true,
      foldmethod = "indent",
      foldenable = false,
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true,      -- sets vim.opt.number
      spell = false,      -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = true,        -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ",                -- sets vim.g.mapleader
      autoformat_enabled = true,      -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true,             -- enable completion at start
      autopairs_enabled = true,       -- enable autopairs at start
      diagnostics_enabled = true,     -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true,           -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    },
  },

  -- Custom Keymappins
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      --
      -- mappings seen under group name "Buffer"
      ["<leader>n"] = { "<cmd>noh<cr>", desc = "No highlight" },
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },

      -- zen-mode mappings
      ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },

      -- control commands
      -- quick save
      ["<C-s>"] = { ":w!<cr>", desc = "Save File" },

      -- Quick Write and Quit
      [";w"] = { ":wa<cr>" },
      [";q"] = { ":q<cr>" },

      -- Navigate buffers
      ["<S-l>"] = { ":bnext<CR>" },
      ["<S-h>"] = { ":bprevious<CR>" },

      -- Move text up and down
      ["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
      ["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },

      -- Toggle between the current and the last buffer
      ["<leader><leader>"] = { "<c-^>" },

      -- Add Blank Lines
      ["<leader>o"] = { ':<C-u>call append(line("."), repeat([""], v:count1))<CR>' },
      ["<leader>O"] = { ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>' },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },
}
