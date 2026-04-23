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
  { import = "nvchad.blink.lazyspec" },

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
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "¦", highlight = "IblChar" },
      scope = { char = "¦", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
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

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
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
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
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
    "folke/sidekick.nvim",
    event = "VeryLazy",
    dependencies = {
      { "github/copilot.vim" },
    },
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle { name = "opencode", focus = true }
        end,
        desc = "Sidekick Toggle OpenCode",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send { msg = "{this}" }
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send { msg = "{file}" }
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send { msg = "{selection}" }
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = true,
  },
}
