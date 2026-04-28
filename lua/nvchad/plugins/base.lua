return {
  {
    "funZX/base46",
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

  { "nvim-lua/plenary.nvim" },
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
  { "nvzone/volt",
    lazy = false,
    dependencies = {
      "funZX/menu",
      config = function(_, opts)
        vim.keymap.set("n", "<RightMouse>", function()
          vim.cmd.exec '"normal! \\<RightMouse>"'

          local options = vim.bo.ft == "snacks_picker_list" and "nvimtree" or "default"
          require("menu").open(options, { mouse = true })
        end, {})
      end,
    }
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
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate | TSInstallAll",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
    end,
  },
}
