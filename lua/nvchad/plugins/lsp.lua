return {

  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",

    config = function()
      require "nvchad.configs.lsp".defaults()
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = true,
  },
}
