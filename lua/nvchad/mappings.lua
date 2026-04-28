local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "General save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General copy whole file" })


-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New buffer" })

  map("n", "<tab>", function()
    require("nvchad.tabufline").next()
  end, { desc = "Buffer goto next" })

  map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "Buffer goto prev" })

  map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "Buffer close" })
end

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })


-- global lsp mappings
map("n", "<leader>cf", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Lsp format file" })


-- dap
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug run/continue" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Debug step over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Debug step into" })

map("n", "<S-F11>", function()
  require("dap").step_out()
end, { desc = "Debug step out" })

map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug set breakpoint" })

map("n", "<S-F9>", function()
  require("dap").set_breakpoint(vim.fn.input('breakpoint condition: '))
end, { desc = "Debug set condition breakpoint" })

map("n", "<leader>d?", function()
  require("dapui").eval()
end, { desc = "Evaluate expression" })

map("n", "<leader>do", function()
  require("dapui").open()
end, { desc = "Open debug view" })

map("n", "<leader>dc", function()
  require("dapui").close()
end, { desc = "Close debug view" })


-- dap python
map("n", "<leader>tc", function()
  require("dap-python").test_class()
end, { desc = "Test python class" })

map("n", "<leader>tm", function()
  require("dap-python").test_method()
end, { desc = "Test python method" })

