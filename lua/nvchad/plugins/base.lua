return {
  { "nvim-lua/plenary.nvim" },
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

  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
  { "nvzone/volt",
    lazy = false,
    dependencies = {
      "nvzone/menu",
      config = function(_, opts)
        vim.keymap.set("n", "<RightMouse>", function()
          vim.cmd.exec '"normal! \\<RightMouse>"'

          local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
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
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "nvchad.configs.nvimtree"
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate | TSInstallAll",
    config = function(_, _)
      opts = require("nvchad.configs.treesitter")
      require("nvim-treesitter.config").setup(opts)
    end,
  },
}
