return {
  {
    "funZX/base46",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "funZX/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true })
        end,
      }
    },
    event = { "User FilePost" },
    branch = "main",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate | TSInstallAll",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
      require('nvim-treesitter-textobjects').setup {
        move = {
          set_jumps = true,
        },
      }
    end
  },
}
