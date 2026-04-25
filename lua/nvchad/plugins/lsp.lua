return {

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",

    dependencies = {
      "ray-x/lsp_signature.nvim",
      config = function()
        require "nvchad.configs.lsp".defaults()
      end,
    },
    opts = {
      symbol_in_winbar = { enable = false },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = true,
  },
}
