return {
  {
    "echaya/neowiki.nvim",
    opts = {
      wiki_dirs = {
        -- neowiki.nvim supports both absolute and tilde-expanded paths
        { name = "Work",     path = "~/.config/wiki/work" },
        { name = "Personal", path = "~/.config/wiki/personal" },
      },
    },
    keys = {
      { "<leader>ww", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Wiki" },
    },
  },
  {
    "brianhuster/live-preview.nvim",
    event = "VeryLazy",
  },
}
