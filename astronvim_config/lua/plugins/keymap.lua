return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },

          -- highlighting
          ["<leader>n"] = { "<cmd>noh<cr>", desc = "No highlight" },

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
          ["go"] = { ':<C-u>call append(line("."), repeat([""], v:count1))<CR>' },
          ["gO"] = { ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>' },

          -- Better movement
          ["j"] = { "gj" },
          ["k"] = { "gk" },
        },
        t = {
          -- setting a mapping to false will disable it
          ["<esc>"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
