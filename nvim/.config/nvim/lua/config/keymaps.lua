-- Nvimtree
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Find current file in explorer" })
vim.keymap.set("n", "<leader>eo", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>gc", "<cmd>NeogitCommit<cr>", { desc = "Open Neogit commit view" })

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
