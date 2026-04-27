pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {

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
    "luadoc",
    "squirrel",
    "html",
    "css",
    "javascript",
    "latex",
    "tsx",
    "typescript",
    "vue",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
  },
  indent = { enable = true },
}
