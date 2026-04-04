return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("neogit").setup({})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "nix" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local function is_executable(path)
        return path ~= nil and vim.fn.executable(path) == 1
      end

      local function is_mason_bin(path)
        return path ~= nil and path:match("/%.local/share/nvim/mason/bin/")
      end

      local function system_binary(bin)
        local path = "/run/current-system/sw/bin/" .. bin

        if is_executable(path) then
          return path
        end
      end

      local function first_non_mason_path_binary(bin)
        for dir in string.gmatch(vim.env.PATH or "", "([^:]+)") do
          local path = dir .. "/" .. bin

          if not is_mason_bin(path) and is_executable(path) then
            return path
          end
        end
      end

      local function preferred_executable(bin)
        return system_binary(bin)
          or first_non_mason_path_binary(bin)
          or (vim.fn.exepath(bin) ~= "" and vim.fn.exepath(bin))
      end

      local lua_ls = preferred_executable("lua-language-server")
      local stylua = preferred_executable("stylua")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = lua_ls and {} or { "lua_ls" },
      })

      vim.lsp.config("lua_ls", lua_ls and {
        cmd = { lua_ls },
        capabilities = capabilities,
      } or {
        capabilities = capabilities,
      })

      vim.lsp.enable("lua_ls")

      if stylua then
        vim.lsp.config("stylua", {
          cmd = { stylua, "--lsp" },
        })
        vim.lsp.enable("stylua")
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
  },
}
