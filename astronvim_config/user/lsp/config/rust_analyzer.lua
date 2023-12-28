return {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            checkOnSave = {
                allFeatures = true,
                command = "clippy",
            },
            procMacro = {
                enable = true
            },
        },
        rust = {
            inlayHints = {
                -- automatically set inlay hints (type hints)
                -- default: true
                auto = false,

                -- Only show inlay hints for the current line
                only_current_line = true,

                -- whether to show parameter hints with the inlay hints or not
                -- default: true
                show_parameter_hints = false,

            },
            -- options same as lsp hover / vim.lsp.util.open_floating_preview()
            hover_actions = {

                -- Maximal width of the hover window. Nil means no max.
                max_width = nil,

                -- Maximal height of the hover window. Nil means no max.
                max_height = nil,

                -- whether the hover action window gets automatically focused
                -- default: false
                auto_focus = true,
            },
        },
    },
}
