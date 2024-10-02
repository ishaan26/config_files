-- get a string of active_clients
local function active_clients()
  local clients = vim.lsp.get_clients()
  local client_string = ""
  for i, v in ipairs(clients) do
    if client_string ~= "typos_lsp" or client_string ~= "null-ls" then
      client_string = client_string .. v.name
      if i > 2 then
        client_string = client_string .. "..."
        break
      end

      if i < #clients then client_string = client_string .. "," end
    end
  end
  return client_string
end

-- configure feline
local function config(_, opts)
  local feline = require "feline"
  local vi_mode = require "feline.providers.vi_mode"
  local file = require "feline.providers.file"
  local separators = require("feline.defaults").statusline.separators.default_value
  local lsp = require "feline.providers.lsp"

  local onedark_theme = {
    black = "#000000",
    white = "#ffffff",
    bg_blue = "#61afef",
    bg_yellow = "#e8c88c",
    fg = "#a0a8b7",
    purple = "#bf68d9",
    green = "#8ebd6b",
    orange = "#cc9057",
    blue = "#4fa6ed",
    yellow = "#e2b86b",
    cyan = "#48b0bd",
    red = "#e55561",
    grey = "#535965",
  }

  local c = {

    -- left
    vim_status = {
      provider = function()
        local s
        if require("lazy.status").has_updates() then
          s = require("lazy.status").updates()
        else
          s = ""
        end
        s = string.format("   %s   ", s)
        return s
      end,

      hl = { fg = onedark_theme.purple, bg = onedark_theme.black },
    },

    file_name = {
      provider = {
        name = "file_info",
        opts = { colored_icon = false },
      },
      hl = { fg = onedark_theme.black, bg = onedark_theme.blue },
      left_sep = {
        always_visible = true,
        str = separators.block,
        hl = { fg = onedark_theme.blue, bg = onedark_theme.blue },
      },
    },

    git_branch = {
      provider = function()
        local git = require "feline.providers.git"
        local branch, icon = git.git_branch()
        local s
        if #branch > 0 then
          s = string.format(" %s%s ", icon, branch)
        else
          s = string.format(" %s ", "Untracked")
        end
        return s
      end,
      hl = { fg = onedark_theme.black, bg = onedark_theme.orange },

      left_sep = {
        always_visible = true,
        str = separators.block,
        hl = { fg = onedark_theme.blue, bg = onedark_theme.black },
      },
    },

    lsp = {
      provider = function()
        if not lsp.is_lsp_attached() then return " 󱏎 LSP " end

        return string.format(" %s [%s] ", require("lsp-progress").progress(), active_clients())
      end,

      hl = function()
        if not lsp.is_lsp_attached() then return { fg = onedark_theme.black, bg = onedark_theme.black } end
        return { fg = onedark_theme.black, bg = onedark_theme.purple }
      end,

      left_sep = {
        always_visible = true,
        str = separators.block,
        hl = { fg = onedark_theme.black, bg = onedark_theme.black },
      },
    },

    git_diff = {
      added = {
        provider = {
          name = "git_diff_added",
        },
        hl = {
          fg = onedark_theme.green,
          bg = onedark_theme.black,
        },
      },

      removed = {
        provider = "git_diff_removed",
        hl = {
          fg = onedark_theme.red,
          bg = onedark_theme.black,
        },
      },

      changed = {
        provider = "git_diff_changed",
        hl = {
          fg = onedark_theme.yellow,
          bg = onedark_theme.black,
        },
      },
    },

    vi_mode = {
      provider = function() return string.format("%s ", vi_mode.get_vim_mode()) end,
      hl = function() return { fg = onedark_theme.black, bg = vi_mode.get_mode_color() } end,
      left_sep = {
        always_visible = true,
        str = separators.block,
        hl = function() return { fg = vi_mode.get_mode_color(), bg = "none" } end,
      },
    },

    -- right
    diagnostics = {
      errors = {
        provider = "diagnostic_errors",
        hl = {
          fg = onedark_theme.red,
          bg = onedark_theme.black,
        },
      },
      warnings = {
        provider = "diagnostic_warnings",
        hl = {
          fg = onedark_theme.yellow,
          bg = onedark_theme.black,
        },
      },
      hints = {
        provider = "diagnostic_hints",
        hl = {
          fg = onedark_theme.purple,
          bg = onedark_theme.black,
        },
      },
    },

    macro = {
      provider = function()
        local s
        local recording_register = vim.fn.reg_recording()
        if #recording_register == 0 then
          s = ""
        else
          s = string.format(" Recording @%s ", recording_register)
        end
        return s
      end,
      hl = { fg = onedark_theme.black, bg = onedark_theme.black },
    },

    search_count = {
      provider = function()
        if vim.v.hlsearch == 0 then return "" end

        local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
        if not ok then return "" end
        if next(result) == nil then return "" end

        local denominator = math.min(result.total, result.maxcount)
        return string.format(" at %d of %d ", result.current, denominator)
      end,
      hl = { fg = onedark_theme.black, bg = onedark_theme.white },
    },

    cursor_position = {
      provider = {
        name = "position",
        opts = { padding = true },
      },
      hl = { fg = onedark_theme.black, bg = onedark_theme.blue },
      left_sep = {
        always_visible = true,
        str = separators.block,
        hl = function() return { fg = onedark_theme.blue, bg = onedark_theme.black } end,
      },
      right_sep = {
        always_visible = true,
        str = " ",
        hl = { fg = onedark_theme.black, bg = onedark_theme.blue },
      },
    },

    scroll_bar = {
      provider = {
        name = "scroll_bar",
        opts = { reverse = true },
      },
      hl = { fg = onedark_theme.yellow, bg = onedark_theme.blue },
    },

    -- inactive statusline
    in_file_info = {
      provider = function()
        if vim.api.nvim_buf_get_name(0) ~= "" then
          return file.file_info({}, { colored_icon = false })
        else
          return file.file_type({}, { colored_icon = false, case = "lowercase" })
        end
      end,
      hl = { fg = onedark_theme.black, bg = onedark_theme.blue },
      left_sep = {
        always_visible = true,
        str = string.format("%s%s", separators.slant_left, separators.block),
        hl = { fg = onedark_theme.blue, bg = "none" },
      },
      right_sep = {
        always_visible = true,
        str = " ",
        hl = { fg = onedark_theme.black, bg = onedark_theme.blue },
      },
    },
  }

  local active = {
    { -- left
      c.vim_status,
      c.vi_mode,
      c.file_name,

      c.git_branch,
      c.git_diff.added,
      c.git_diff.removed,
      c.git_diff.changed,
    },
    { -- right
      c.diagnostics.errors,
      c.diagnostics.warnings,
      c.diagnostics.hints,
      c.macro,
      c.search_count,
      c.lsp,
      c.cursor_position,
      c.scroll_bar,
    },
  }

  local inactive = {
    { -- left
    },
    { -- right
      c.in_file_info,
    },
  }

  opts.components = { active = active, inactive = inactive }

  feline.setup(opts)
  feline.use_theme(onedark_theme)
end

return {
  {
    "freddiehaddad/feline.nvim",
    config = config,
    dependencies = {
      "EdenEast/nightfox.nvim",
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "linrongbin16/lsp-progress.nvim",
        opts = {
          spinner = {
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
          },
          spin_update_time = 500,
          max_size = 30,
          client_format = function(_, spinner, series_messages)
            return #series_messages > 0 and (spinner .. "  " .. table.concat(series_messages, "  ")) or "  "
          end,
          format = function(client_messages)
            local sign = " "
            if #client_messages > 0 then return table.concat(client_messages) end
            if #vim.lsp.get_clients() > 0 then return sign end
            return "󱏎 LSP"
          end,
        },
      },
    },
    init = function()
      -- use a global statusline
      -- vim.opt.laststatus = 3

      -- update statusbar when there's a plugin update
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyCheck",
        callback = function() vim.opt.statusline = vim.opt.statusline end,
      })

      -- update statusbar with LSP progress
      vim.api.nvim_create_augroup("feline_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "feline_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = function() vim.opt.statusline = vim.opt.statusline end,
      })

      -- hide the mode
      vim.opt.showmode = false

      -- hide search count on command line
      vim.opt.shortmess:append { S = true }
    end,
    opts = {
      force_inactive = { filetypes = { "^dapui_*", "^help$", "^neotest*", "^NvimTree$", "^qf$" } },
      disable = { filetypes = { "^alpha$" } },
    },
  },
  {
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts) opts.statusline = nil end,
  },
}
