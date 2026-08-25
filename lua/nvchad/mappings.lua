local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "General save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General copy whole file" })


-- tabufline
-- stylua: ignore start
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New buffer" })
  map("n", "<tab>",      function() require("nvchad.tabufline").next() end,         { desc = "Buffer goto next" })
  map("n", "<S-tab>",    function() require("nvchad.tabufline").prev() end,         { desc = "Buffer goto prev" })
  map("n", "<leader>x",  function() require("nvchad.tabufline").close_buffer() end, { desc = "Buffer close" })
end

-- comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc",  { desc = "Toggle comment", remap = true })

-- lsp
map("n", "<leader>ce", function() vim.lsp.buf.rename() end,              { desc = "Rename (Lsp)" })
map("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Lsp format file" })

-- dap
map("n", "<F5>",    function() require("dap").continue() end,                                  { desc = "Debug run/continue" })
map("n", "<F10>",   function() require("dap").step_over() end,                                 { desc = "Debug step over" })
map("n", "<F11>",   function() require("dap").step_into() end,                                 { desc = "Debug step into" })
map("n", "<S-F11>", function() require("dap").step_out() end,                                  { desc = "Debug step out" })
map("n", "<F9>",    function() require("dap").toggle_breakpoint() end,                          { desc = "Debug set breakpoint" })
map("n", "<S-F9>",  function() require("dap").set_breakpoint(vim.fn.input('breakpoint condition: ')) end, { desc = "Debug set condition breakpoint" })

-- dap ui
map("n", "<leader>d?", function() require("dapui").eval() end,  { desc = "Evaluate expression" })
map("n", "<leader>do", function() require("dapui").open() end,  { desc = "Open debug view" })
map("n", "<leader>dc", function() require("dapui").close() end, { desc = "Close debug view" })

-- dap python
map("n", "<leader>tc", function() require("dap-python").test_class() end,  { desc = "Test python class" })
map("n", "<leader>tm", function() require("dap-python").test_method() end, { desc = "Test python method" })


-- treesitter textobjects
local select = require "nvim-treesitter-textobjects.select"
local swap = require "nvim-treesitter-textobjects.swap"
local move = require "nvim-treesitter-textobjects.move"

local xo = { "x", "o" }
local nxo = { "n", "x", "o" }

-- textobject select
map(xo, "ac", function() select.select_textobject("@conditional.outer", "textobjects") end, { desc = "TextObject select conditional outer" })
map(xo, "ic", function() select.select_textobject("@conditional.inner", "textobjects") end, { desc = "TextObject select conditional inner" })
map(xo, "af", function() select.select_textobject("@function.outer",    "textobjects") end, { desc = "TextObject select function outer" })
map(xo, "if", function() select.select_textobject("@function.inner",    "textobjects") end, { desc = "TextObject select function inner" })
map(xo, "ak", function() select.select_textobject("@class.outer",       "textobjects") end, { desc = "TextObject select class outer" })
map(xo, "ik", function() select.select_textobject("@class.inner",       "textobjects") end, { desc = "TextObject select class inner" })
map(xo, "aa", function() select.select_textobject("@parameter.inner",   "textobjects") end, { desc = "TextObject select parameter outer" })
map(xo, "ia", function() select.select_textobject("@parameter.inner",   "textobjects") end, { desc = "TextObject select parameter inner" })
map(xo, "al", function() select.select_textobject("@loop.outer",        "textobjects") end, { desc = "TextObject select loop outer" })
map(xo, "il", function() select.select_textobject("@loop.inner",        "textobjects") end, { desc = "TextObject select loop inner" })
map(xo, "ao", function() select.select_textobject("@comment.outer",     "textobjects") end, { desc = "TextObject select comment outer" })
map(xo, "io", function() select.select_textobject("@comment.outer",     "textobjects") end, { desc = "TextObject select comment inner" })

-- textobject move: next
map(nxo, "]c", function() move.goto_next_start("@conditional.outer", "textobjects") end, { desc = "TextObject goto next conditional start" })
map(nxo, "]f", function() move.goto_next_start("@function.outer",    "textobjects") end, { desc = "TextObject goto next function start" })
map(nxo, "]k", function() move.goto_next_start("@class.outer",       "textobjects") end, { desc = "TextObject goto next class start" })
map(nxo, "]l", function() move.goto_next_start("@loop.outer",        "textobjects") end, { desc = "TextObject goto next loop start" })

map(nxo, "]C", function() move.goto_next_end("@conditional.outer", "textobjects") end, { desc = "TextObject goto next conditional end" })
map(nxo, "]F", function() move.goto_next_end("@function.outer",    "textobjects") end, { desc = "TextObject goto next function end" })
map(nxo, "]K", function() move.goto_next_end("@class.outer",       "textobjects") end, { desc = "TextObject goto next class end" })
map(nxo, "]L", function() move.goto_next_end("@loop.outer",        "textobjects") end, { desc = "TextObject goto next loop end" })

-- textobject move: previous
map(nxo, "[c", function() move.goto_previous_start("@conditional.outer", "textobjects") end, { desc = "TextObject goto prev conditional start" })
map(nxo, "[f", function() move.goto_previous_start("@function.outer",    "textobjects") end, { desc = "TextObject goto prev function start" })
map(nxo, "[k", function() move.goto_previous_start("@class.outer",       "textobjects") end, { desc = "TextObject goto prev class start" })
map(nxo, "[l", function() move.goto_previous_start("@loop.outer",        "textobjects") end, { desc = "TextObject goto prev loop start" })

map(nxo, "[C", function() move.goto_previous_end("@conditional.outer", "textobjects") end, { desc = "TextObject goto prev conditional end" })
map(nxo, "[F", function() move.goto_previous_end("@function.outer",    "textobjects") end, { desc = "TextObject goto prev function end" })
map(nxo, "[K", function() move.goto_previous_end("@class.outer",       "textobjects") end, { desc = "TextObject goto prev class end" })
map(nxo, "[L", function() move.goto_previous_end("@loop.outer",        "textobjects") end, { desc = "TextObject goto prev loop end" })

-- textobject swap
map("n", "<leader>]c", function() swap.swap_next("@conditional.outer") end, { desc = "TextObject swap next conditional" })
map("n", "<leader>]a", function() swap.swap_next("@parameter.inner")   end, { desc = "TextObject swap next parameter" })
map("n", "<leader>]f", function() swap.swap_next("@function.outer")    end, { desc = "TextObject swap next function" })

map("n", "<leader>[c", function() swap.swap_previous("@conditional.outer") end, { desc = "TextObject swap prev conditional" })
map("n", "<leader>[a", function() swap.swap_previous("@parameter.inner")   end, { desc = "TextObject swap prev parameter" })
map("n", "<leader>[f", function() swap.swap_previous("@function.outer")    end, { desc = "TextObject swap prev function" })
-- stylua: ignore end

