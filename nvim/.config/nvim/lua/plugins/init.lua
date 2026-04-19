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
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    version = "^1.0.0",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          initial_mode = "normal",
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
            },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*" }
            end,
          },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "nix", "elixir", "eex", "heex" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "vim", "help", "nix", "elixir", "eelixir", "eex", "heex", "surface" },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
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
      local elixirls = preferred_executable("elixir-ls")
      local qmlls = preferred_executable("qmlls")
      local qmlformat = preferred_executable("qmlformat")
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

      if qmlls then
        vim.lsp.config("qmlls", {
          cmd = { qmlls },
          filetypes = { "qml", "qmljs" },
          capabilities = capabilities,
          settings = qmlformat and {
            qml = {
              formatCommand = { qmlformat },
            },
          } or nil,
        })
        vim.lsp.enable("qmlls")
      end

      if stylua then
        vim.lsp.config("stylua", {
          cmd = { stylua, "--lsp" },
        })
        vim.lsp.enable("stylua")
      end

      if elixirls then
        vim.lsp.config("elixirls", {
          cmd = { elixirls },
          capabilities = capabilities,
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              fetchDeps = false,
              enableTestLenses = false,
              suggestSpecs = true,
            },
          },
        })
        vim.lsp.enable("elixirls")
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
