return {
  { import = "nvchad.blink.lazyspec" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")
      require("ibl").setup(opts)
    end,
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "dap")
    end,
    config = function(_, opts)
      require "nvchad.configs.dap"

      require("dap-python").setup("~/.local/venv/debugpy/bin/python", { test_runner = "unittest" })
      require("dapui").setup(opts)
    end,
  },
}
