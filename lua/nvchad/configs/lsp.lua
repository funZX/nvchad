local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "lsp add workspace folder"})
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "lsp remove workspace folder"})
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "lsp list workspace folders"})
  map("n", "<leader>gR", require "nvchad.lsp.renamer", { desc = "lsp rename"})

  -- lsp saga
  map("n", "<leader>gr", "<cmd>Lspsaga finder<cr>", { desc = "lsp references" })
  map("n", "<leader>ga", "<cmd>Lspsaga code_action<cr>", { desc = "lsp code actions" })
  map("n", "<leader>gh", "<cmd>Lspsaga hover_doc <cr>", { desc = "lsp hover" })
  map("n", "<leader>gd", "<cmd>Lspsaga goto_definition <cr>", { desc = "lsp goto definition" })
  map("n", "<leader>gD", "<cmd>Lspsaga peek_definition <cr>", { desc = "lsp peek definition" })
  map("n", "<leader>gt", "<cmd>Lspsaga goto_type_definition <cr>", { desc = "lsp goto type definition" })
  map("n", "<leader>gT", "<cmd>Lspsaga peek_type_definition <cr>", { desc = "lsp peek type definition" })
  map("n", "<leader>g?", "<cmd>Lspsaga show_line_diagnostics <cr>", { desc = "lsp line diagnostic" })
  map("n", "<leader>gg", "<cmd>Lspsaga show_buf_diagnostics <cr>", { desc = "lsp buffer diagnostic" })
  map("n", "<leader>gG", "<cmd>Lspsaga show_workspace_diagnostics <cr>", { desc = "lsp workspace diagnostics" })
  map("n", "<leader>g[", "<cmd>Lspsaga diagnostic_jump_prev <cr>", { desc = "lsp previous diagnostic" })
  map("n", "<leader>g]", "<cmd>Lspsaga diagnostic_jump_next <cr>", { desc = "lsp next diagnostic" })

  require "lsp_signature".on_attach({
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
end

-- disable semanticTokens
M.on_init = function(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.general.positionEncodings = { "utf-16" }
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })
  

  vim.lsp.config("bashls", require("nvchad.configs.lsp.bashls"))
  vim.lsp.config("clangd", require("nvchad.configs.lsp.clangd"))
  vim.lsp.config("rusta", require("nvchad.configs.lsp.rusta"))
  vim.lsp.config("gopls", require("nvchad.configs.lsp.gopls"))
  vim.lsp.config("ruff", require("nvchad.configs.lsp.ruff"))
  vim.lsp.config("robot", require("nvchad.configs.lsp.robot"))
  vim.lsp.config("ts_ls", require("nvchad.configs.lsp.ts_ls"))
  vim.lsp.config("vue_ls", require("nvchad.configs.lsp.vue_ls"))

  -- Use new vim.lsp.config API for Neovim 0.11+
  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init, on_attach = M.on_attach })
  vim.lsp.enable({"bashls", "clangd", "rusta", "gopls", "ruff", "robot", "ts_ls", "vue_ls"})

  local dap, dapui = require("dap"), require("dapui")

  dap.listeners.before.attach.dapui_config = function()
      dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
      dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
  end


  vim.api.nvim_set_hl(0, "red", { fg = "#f03000" })
  vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
  vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition',{ text = '󱗜', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointRejected',{ text = '', texthl = 'orange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapStopped', { text = '', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

  vim.diagnostic.config {
      virtual_text = { prefix = "󰧞"},
  }
end

return M
