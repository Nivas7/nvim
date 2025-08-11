return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
        vim.lsp.enable("jdtls")
    end
}
