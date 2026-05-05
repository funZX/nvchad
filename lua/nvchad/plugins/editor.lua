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
  { delphinus/md-render.nvim },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   ft = { 'markdown' },
  --   opts = {
  --       render_modes = true,
  --   },
  --   config = function(_, opts)
  --     require("render-markdown").setup(opts)
  --   end,
  -- }
}
