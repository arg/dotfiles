-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
-- }}}

-- Options {{{
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.bufhidden = "wipe"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "120"
vim.opt.completeopt = "menu,menuone,preview,noselect,noinsert"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " " }
vim.opt.foldenable = true
vim.opt.formatoptions:remove("t")
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = "**", trail = "·" }
vim.opt.modelines = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")
vim.opt.runtimepath:prepend(lazypath)
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.switchbuf:remove("split")
vim.opt.tabstop = 2
vim.opt.termencoding = "utf8"
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wrap = false

vim.g.mapleader = ","

local disabled_builtin_plugins = { "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "tutor" }
for _, plugin in pairs(disabled_builtin_plugins) do
   vim.g["loaded_" .. plugin] = 1
end
-- }}}

-- Plugins {{{
require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = false,
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = false
        },
        strikethrough = true
      })
      vim.cmd("colorscheme gruvbox")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "ruby", "dockerfile", "fish", "json", "yaml", "html", "javascript", "scss", "rust",
                           "terraform", "toml", "lua" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" }
      },
      indent = {
        enable = true,
        disable = { "ruby" }
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<space>",
          node_incremental = "<space>",
          node_decremental = "<bs>",
          scope_incremental = "<tab>",
        }
      }
    }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2",
    build = "make" -- this command may fail on M1, in this case run "make clean && make" manually from the plugin's dir
  },
  {
    "nvim-telescope/telescope-ui-select.nvim"
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
                     "nvim-telescope/telescope-fzf-native.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "^.git/", ".lock", ".keep", ".enc", "db/schema.rb" }
        },
        pickers = {
          find_files = { hidden = true }
        }
      })
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { autocomplete = false },
        sources = {
          { name = "nvim_lsp" }
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local nvim_lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      nvim_lsp.solargraph.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 }
      })
      nvim_lsp.stylelint_lsp.setup({
        flags = { debounce_text_changes = 500 },
        settings = {
          stylelintplus = { autoFixOnFormat = true }
        }
      })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = false,
          signs = true,
          update_in_insert = false
        }
      )
    end
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "none",
        close_command = "bdelete! %d",
        indicator = { style = "none" },
        max_name_length = 20,
        max_prefix_length = 15,
        tab_size = 20,
        diagnostics = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            text_align = "left"
          }
        },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        separator_style = { "", "" },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = "id"
      },
      highlights = {
        fill = { bg = "#282828" },
        background = { bg = "#282828" },
        buffer_selected = { bg = "#3c3836" }
      }
    }
  },
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      open_on_tab = true,
      git = { enable = true },
      renderer = {
        root_folder_label = false,
        special_files = { "README.md", "Gemfile" },
        icons = {
          git_placement = "signcolumn",
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false
          }
        }
      },
      filters = {
        custom = { "^.git$" }
      },
      actions = {
        change_dir = { enable = false },
      },
      view = {
        signcolumn = "no",
        width = 40
      }
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-tree.lua" },
    config = function()
      local custom_gruvbox = require("lualine.themes.gruvbox")
      custom_gruvbox.normal.c.bg = "#3c3836"
      custom_gruvbox.normal.c.fg = "#928374"
      custom_gruvbox.insert.c.bg = "#3c3836"
      custom_gruvbox.insert.c.fg = "#928374"
      custom_gruvbox.visual.c.bg = "#3c3836"
      custom_gruvbox.visual.c.fg = "#928374"
      custom_gruvbox.replace.c.bg = "#3c3836"
      custom_gruvbox.replace.c.fg = "#928374"
      custom_gruvbox.command.c.bg = "#3c3836"
      custom_gruvbox.command.c.fg = "#928374"

      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = custom_gruvbox,
          component_separators = "",
          section_separators = "",
          always_divide_middle = true,
          globalstatus = true
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filetype" },
          lualine_c = {
            {
              "filename",
              path = 1
            }
          },
          lualine_x = { "branch" },
          lualine_y = { "location" },
          lualine_z = {
            {
              "diagnostics",
              sections = { "error", "warn", "info" },
              colored = false,
              always_visible = true,
              symbols = { error = "", warn = "/", info = "/" },
              fmt = function(str)
                return str:gsub("%s+", "")
              end
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        extensions = { "nvim-tree" }
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = true
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "mhinz/vim-sayonara"
  },
  {
    "pocco81/auto-save.nvim",
    branch = "dev",
    commit = "9aceacfd184c34a2d878492a67bbd6b909b9480c",
    opts = {
      execution_message = { message = "" },
      trigger_events = { "InsertLeave", "TextChanged" }
    }
  },
  {
    "terrortylor/nvim-comment",
    main = "nvim_comment",
    opts = {
      marker_padding = true,
      create_mappings = false
    }
  },
  {
    "github/copilot.vim"
  },
  {
    "ethanholz/nvim-lastplace",
    config = true
  },
  {
    "vim-ruby/vim-ruby",
    config = function()
      vim.g.ruby_indent_assignment_style = "variable"
    end
  },
  {
    "tpope/vim-rails",
    dependencies = { "vim-ruby/vim-ruby" },
    config = function()
      vim.g.rails_projections = {
        ["app/lib/*.rb"] = {
          test = "spec/lib/{}_spec.rb",
        }
      }
    end
  },
  {
    "ojroques/nvim-osc52"
  }
})
-- }}}

-- Keymaps {{{
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })
vim.keymap.set("n", "//", ":nohlsearch<CR>", { silent = true, desc = "Clear selection highlight" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Go to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Go to previous buffer" })
vim.keymap.set("n", "<C-w>", ":Sayonara!<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "J", "<PageDown>", { silent = true, desc = "Next page" })
vim.keymap.set("n", "K", "<PageUp>", { silent = true, desc = "Previous page" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Navigate left" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Navigate down" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Navigate up" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Navigate right" })
vim.keymap.set("n", "<C-o>", ":Telescope find_files<CR>", { silent = true, desc = "Find file" })
vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", { silent = true, desc = "Search text in all files" })
vim.keymap.set("n", "<C-f>", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "List LSP symbols from current file" })
vim.keymap.set("n", "<C-t>", ":Telescope lsp_workspace_symbols<CR>", { silent = true, desc = "List LSP symbols from all files" })
vim.keymap.set({ "n", "v" }, "<Leader>c", ":CommentToggle<CR>", { silent = true, desc = "Toggle line comment" })
vim.keymap.set("n", "<C-s>", function() vim.lsp.buf.format({ async = true }) end, { silent = true, desc = "Format code" })
vim.keymap.set("n", "<C-]>", function() vim.lsp.buf.definition() end, { silent = true, desc = "Go to definition" })
vim.keymap.set("n", "<Leader>g", ":0G<CR>", { silent = true, desc = "Show Git window" })
-- }}}

-- Autocmd {{{
vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable spell checking for certain file types",
  pattern = { "text", "markdown", "mail", "gitcommit", "cucumber" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show LSP diagnostics window on cursor hold",
  pattern = "",
  callback = function()
    vim.diagnostic.open_float(0, { scope = "cursor", focus = false })
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Copy to clipboard/tmux/OSC52",
  pattern = "",
  callback = function()
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      require("osc52").copy_register(vim.v.event.regname)
    end
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end
})
-- }}}

-- vim:foldmethod=marker:foldlevel=0
