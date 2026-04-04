-- Nvimtree
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find current file in explorer" })
vim.keymap.set("n", "<leader>eo", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })
vim.keymap.set("n", "zl", "<cmd>vertical resize +5<cr>", { desc = "Increase split width" })
vim.keymap.set("n", "zh", "<cmd>vertical resize -5<cr>", { desc = "Decrease split width" })
vim.keymap.set("n", "zk", "<cmd>resize +2<cr>", { desc = "Increase split height" })
vim.keymap.set("n", "zj", "<cmd>resize -2<cr>", { desc = "Decrease split height" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>gc", "<cmd>NeogitCommit<cr>", { desc = "Open Neogit commit view" })

-- Gitsigns
vim.keymap.set("n", "]h", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
  require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })

-- Buffers
vim.keymap.set("n", "<leader>bb", "<cmd>BufferPick<cr>", { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferPrevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>BufferNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "H", "<cmd>BufferPrevious<cr>", { desc = "Previous buffer" })

-- LSP
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Search in files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Oil 
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>oo", "<cmd>Oil<cr>", { desc = "Oil: Open parent directory" })
vim.keymap.set("n", "<leader>of", "<cmd>Oil --float<cr>", { desc = "Oil: Open parent directory in floating window" })
vim.keymap.set("n", "<leader>oc", "<cmd>Oil .<cr>", { desc = "Oil: Open current directory" })
vim.keymap.set("n", "<leader>oh", "<cmd>Oil ~<cr>", { desc = "Oil: Open home directory" })
vim.keymap.set("n", "<leader>or", "<cmd>Oil /<cr>", { desc = "Oil: Open root directory" })
vim.keymap.set("n", "<M-o>", "<cmd>Oil<cr>", { desc = "Alt+o: Open Oil" })
vim.keymap.set("n", "<M-O>", "<cmd>Oil --float<cr>", { desc = "Alt+O: Open Oil in float" })

-- These will only kick in when an Oil buffer is open

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      require("oil").select()
    end, { buffer = true, desc = "Oil: Enter directory/open file" })

    vim.keymap.set("n", "g.", function()
      require("oil").toggle_hidden()
    end, { buffer = true, desc = "Oil: Toggle hidden files" })

    vim.keymap.set("n", "gx", function()
      require("oil").open_external()
    end, { buffer = true, desc = "Oil: Open with system default" })

    vim.keymap.set("n", "<C-p>", function()
      require("oil").preview()
    end, { buffer = true, desc = "Oil: Preview file" })

    vim.keymap.set("n", "<C-c>", function()
      require("oil").close()
    end, { buffer = true, desc = "Oil: Close oil" })

    vim.keymap.set("n", "<C-l>", function()
      require("oil").refresh()
    end, { buffer = true, desc = "Oil: Refresh" })

    vim.keymap.set("n", "q", function()
      require("oil").close()
    end, { buffer = true, desc = "Oil: Quit oil" })
  end,
})
