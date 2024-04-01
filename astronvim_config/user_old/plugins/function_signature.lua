return {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
        require("lsp_signature").setup({
            floating_window = false,
        })
    end,
}
