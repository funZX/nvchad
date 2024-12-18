pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  ensure_installed = {
    "c",
    "cpp",
    "python",
    "go",
    "rust",
    "robot",
    "lua",
    "squirrel",
    "jsonc",
    "html",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
  },
  indent = { enable = true },
}
