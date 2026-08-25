return {

  {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup(
              {
                  nes = {enabled = true},
                  panel = {
                      keymap = {
                          -- jump_prev = false,
                          -- jump_next = false,
                          accept = "<CR>",
                          dismiss = "<Esc>",
                      },
                  }
              }
          )
        end,
      },
      { "copilotlsp-nvim/copilot-lsp" },
    },
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = false,
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
}
