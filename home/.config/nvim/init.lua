-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_commit = "306a05526ada86a7b30af95c5cc81ffba93fef97" -- v11.17.5+4 (2025-12-17)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--no-checkout", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "--quiet", lazy_commit })
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
--vim.opt.termencoding = "utf8"
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wrap = false

vim.g.mapleader = ","

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.editorconfig_enable = false

-- vim.g.clipboard = 'osc52'

local disabled_builtin_plugins = { "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "tutor" }
for _, plugin in pairs(disabled_builtin_plugins) do
   vim.g["loaded_" .. plugin] = 1
end
-- }}}

-- {{{ Clipboard
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

local osc52 = require("vim.ui.clipboard.osc52")

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy("+"),
    ["*"] = osc52.copy("*")
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste
  }
}
-- }}}

-- LSP {{{
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    },
    offsetEncoding =  { "utf-8" }
  },
})

-- install LSP with:
-- gem install ruby-lsp
-- gem install rubocop
-- npm install -g @cucumber/language-server (Node.js v22 required)

  -- ruby-lsp {{{
vim.lsp.config("ruby-lsp", {
  cmd = { "env", "RUBY_YJIT_ENABLE=1", "bundle", "exec", "ruby-lsp" },
  filetypes = { "ruby" },
  init_options = {
    formatter = "none"
  }
})
vim.lsp.enable("ruby-lsp", {
  on_init = function(client, _)
    -- I don't like this semantic highlighting. IMO vim-ruby does a better job.
    client.server_capabilities.semanticTokensProvider = false
    -- Uncomment the following lines if you want to use standalone Rubocop for diagnostics and formatting
    client.server_capabilities.diagnosticProvider = false
    client.server_capabilities.documentFormattingProvider = false
  end
})
  -- }}}

  -- rubocop {{{
vim.lsp.config("rubocop", {
  cmd = { "env", "RUBY_YJIT_ENABLE=1", "bundle", "exec", "rubocop", "--lsp" },
  filetypes = { "ruby" }
})
vim.lsp.enable("rubocop")
-- }}}

  -- cucumber-language-server {{{
vim.lsp.config("cucumber_language_server", {
  cmd = { "npx", "cucumber-language-server", "--stdio" },
  filetypes = { "cucumber" }
})
vim.lsp.enable("cucumber_language_server")
  -- }}}

-- }}}

-- Plugins {{{
require("lazy").setup({
  -- lazy.nvim {{{
  {
    "folke/lazy.nvim",
    commit = lazy_commit
  },
  -- }}}
  -- gruvbox.nvim {{{
  {
    "ellisonleao/gruvbox.nvim",
    commit = "154eb5ff5b96d0641307113fa385eaf0d36d9796", -- 2.0.0+122 (2026-04-15)
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = false,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false
        },
        strikethrough = true
      })
      vim.cmd.colorscheme("gruvbox")
    end
  },
  -- }}}
  -- nvim-treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = "a9c4e1457e2e59f1b82c8f78dcdb3b2517555200", -- main@2026-10-31
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "ruby", "dockerfile", "fish", "json", "yaml", "html", "javascript", "scss",
                                           "rust", "terraform", "toml", "lua", "pascal", "go" })
    end
  },
  -- }}}
  -- telescope {{{
  {
    "nvim-telescope/telescope.nvim",
    commit = "1e1bab730218eaf97fce743be3f56e51075928ac", -- v0.2.2+30 (2026-11-08)
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
                     "nvim-telescope/telescope-ui-select.nvim",
                     "debugloop/telescope-undo.nvim" },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "^.git/", ".lock$", ".keep$", ".enc$", "^coverage/", "^tmp/", "^log/" },
        },
        pickers = {
          find_files = { hidden = true }
        },
        extensions = {
          undo = {
            mappings = {
              n = {
                ["<CR>"] = require("telescope-undo.actions").restore,
              },
            },
          },
        }
      })
      telescope.load_extension("ui-select")
      telescope.load_extension("undo")
    end
  },
  -- }}}
  -- nvim-cmp {{{
  {
    "hrsh7th/nvim-cmp",
    commit = "2ffe79f1f021def8dd1fcd81deb16f1bb0d989f3", -- v0.0.2+33 (2026-07-10)
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
  -- }}}
  -- nvim-lspconfig (disabled) {{{
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = { "hrsh7th/cmp-nvim-lsp" },
  --   config = function()
  --     local nvim_lsp = require("lspconfig")
  --     local capabilities = vim.tbl_deep_extend(
  --       "force",
  --       vim.lsp.protocol.make_client_capabilities(),
  --       require("cmp_nvim_lsp").default_capabilities()
  --     )
  --     local flags = { debounce_text_changes = 500 }
  --     nvim_lsp.ruby_lsp.setup({
  --       capabilities = capabilities,
  --       flags = flags,
  --       cmd = { "env", "RUBY_YJIT_ENABLE=1", "bundle", "exec", "ruby-lsp" },
  --       settings = {
  --         init_options = {
  --           formatter = "rubocop"
  --         }
  --       },
  --       on_init = function(client, _)
  --         -- I don't like this semantic highlighting. IMO vim-ruby does a better job.
  --         client.server_capabilities.semanticTokensProvider = false
  --         -- Uncomment the following lines if you want to use standalone Rubocop for diagnostics and formatting
  --         -- client.server_capabilities.diagnosticProvider = false
  --         -- client.server_capabilities.documentFormattingProvider = false
  --       end
  --     })
  --     -- nvim_lsp.rubocop.setup({
  --     --   capabilities = capabilities,
  --     --   flags = flags,
  --     --   cmd = { "env", "RUBY_YJIT_ENABLE=1", "bundle", "exec", "rubocop", "--lsp" }
  --     -- })
  --     -- nvim_lsp.stylelint_lsp.setup({
  --     --   capabilities = capabilities,
  --     --   flags = flags,
  --     --   cmd = { "npx", "stylelint-lsp", "--stdio" },
  --     --   filetypes = { "css", "less", "postcss", "sass", "scss" },
  --     --   settings = {
  --     --     stylelintplus = { autoFixOnFormat = true }
  --     --   }
  --     -- })
  --     -- nvim_lsp.tailwindcss.setup({
  --     --   capabilities = capabilities,
  --     --   flags = flags,
  --     --   cmd = { "npx", "tailwindcss-language-server", "--stdio" },
  --     --   filetypes = { "css", "less", "postcss", "sass", "scss" }
  --     -- })
  --     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --       vim.lsp.diagnostic.on_publish_diagnostics,
  --       {
  --         virtual_text = false,
  --         signs = true,
  --         update_in_insert = false
  --       }
  --     )
  --   end
  -- },
  -- }}}
  -- bufferline {{{
  {
    "akinsho/bufferline.nvim",
    commit = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3", -- v4.9.1 (2025-01-14)
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
  -- }}}
  -- nvim-tree {{{
  {
    "nvim-tree/nvim-tree.lua",
    commit = "f632f208c52e942af1db6d3793ccdd4752dd28ac", -- v1.19+6 (2026-11-02)
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
        custom = { "^.git$", "^node_modules$", "^tmp$", "^log$", "^coverage$" }
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
  -- }}}
  -- lualine {{{
  {
    "nvim-lualine/lualine.nvim",
    commit = "221ce6b2d999187044529f49da6554a92f740a96", -- master@2026-05-31
    dependencies = { "nvim-tree/nvim-tree.lua" },
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
  -- }}}
  -- gitsigns {{{
  {
    "lewis6991/gitsigns.nvim",
    commit = "1e9d0fbfe7ff848bc402d2c2e2854fb4eff2dce7", -- v2.1.0+80 (2026-10-29)
    config = true
  },
  -- }}}
  -- vim-fugitive {{{
  {
    "tpope/vim-fugitive",
    commit = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0" -- v3.7+193 (2026-03-07)
  },
  -- }}}
  -- vim-sayonara {{{
  {
    "mhinz/vim-sayonara",
    commit = "75c73f3cf3e96f8c09db5291970243699aadc02c" -- master@2021-09-03
  },
  -- }}}
  -- auto-save {{{
  {
    "pocco81/auto-save.nvim",
    branch = "dev",
    commit = "9aceacfd184c34a2d878492a67bbd6b909b9480c", -- dev@2022-08-08
    opts = {
      execution_message = { message = "" },
      trigger_events = { "InsertLeave", "TextChanged" }
    }
  },
  -- }}}
  -- nvim-comment {{{
  {
    "terrortylor/nvim-comment",
    commit = "e9ac16ab056695cad6461173693069ec070d2b23", -- main@2022-08-09
    main = "nvim_comment",
    opts = {
      marker_padding = true,
      create_mappings = false
    }
  },
  -- }}}
  -- copilot {{{
  {
    "github/copilot.vim",
    commit = "a12fd5672110c8aa7e3c8419e28c96943ca179be", -- v1.59.0 (2026-01-09)
    config = function()
      -- Apparently there is a bug somewhere (Copilot?) that adds extra characters when using <C-J>
      -- This is why I have to rely on the default mapping for now (<Tab>), which may conflict with other plugins
      -- Also to prevent Copilot from reporing errors at :Copilot status, I have to set copilot_assume_mapped = true
      -- Also copilot_no_tab_map doesn't seem to work :/
      -- vim.g.copilot_no_tab_map = true
      -- vim.g.copilot_assume_mapped = true
      -- vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
  },
  -- }}}
  -- nvim-lastplace {{{
  {
    "ethanholz/nvim-lastplace",
    commit = "0bb6103c506315044872e0f84b1f736c4172bb20", -- main@2023-07-27
    config = true
  },
  -- }}}
  -- vim-ruby {{{
  {
    "vim-ruby/vim-ruby",
    commit = "bf3a5994ce63796db7b1b04aea92772271f387aa", -- master@2025-04-28
    config = function()
      vim.g.ruby_indent_assignment_style = "variable"
    end
  },
  -- }}}
  -- vim-test {{{
  {
    "vim-test/vim-test",
    commit = "7a5f7e1848b573de556adffe718097933d827d32", -- v3.6.0+1 (2026-11-01)
    dependencies = { "preservim/vimux" },
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.g.VimuxOrientation = "h"
      vim.g.VimuxHeight = "40"
    end
  },
  -- }}}
  -- vim-rails {{{
  {
    "tpope/vim-rails",
    commit = "b0a5c76f86ea214ade36ab0b811e730c3f0add67", -- v5.4+253 (2025-02-19)
    dependencies = { "vim-ruby/vim-ruby" },
    config = function()
      vim.g.rails_projections = {
        ["app/lib/*.rb"] = {
          test = "spec/lib/{}_spec.rb",
        }
      }
    end
  },
  -- }}}
  -- NeoTest {{{
  {
  "nvim-neotest/neotest",
    commit = "27bf921498043f7ecd821d6db68d05de244bbd02", -- v5.20.0+1 (2026-08-16)
    dependencies = { "olimorris/neotest-rspec", "nvim-neotest/nvim-nio" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")
        }
      })
    end
  },
  -- }}}
  -- Dependencies {{{
  {
    "nvim-lua/plenary.nvim",
    commit = "74b06c6c75e4eeb3108ec01852001636d85a932b" -- v0.1.4+40 (2026-04-10)
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    commit = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2" -- master@2023-12-04
  },
  {
    "debugloop/telescope-undo.nvim",
    commit = "928d0c2dc9606e01e2cc547196f48d2eaecf58e5" -- main@2025-01-31
  },
  {
    "preservim/vimux",
    commit = "d6cb7f63a8bb428ffc27060b7f83c77fb115589c" -- 1.1.0+114 (2026-02-27)
  },
  {
    "olimorris/neotest-rspec",
    commit = "7629f8c2837becb72090fbafce58506bb56a00f0" -- main@2026-06-18
  },
  {
    "nvim-neotest/nvim-nio",
    commit = "edcc181a875301dd21840189aa2f2f9ad69fc172" -- v1.10.1+1 (2026-07-15)
  }
  -- }}}
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
vim.keymap.set("n", "<C-u>", ":Telescope undo<CR>", { silent = true, desc = "Show undo tree" })
vim.keymap.set({ "n", "v" }, "<Leader>c", ":CommentToggle<CR>", { silent = true, desc = "Toggle line comment" })
vim.keymap.set("n", "<C-s>", function() vim.lsp.buf.format({ async = true }) end, { silent = true, desc = "Format code" })
vim.keymap.set("n", "<C-]>", function() vim.lsp.buf.definition() end, { silent = true, desc = "Go to definition" })
vim.keymap.set("n", "<Leader>g", ":0G<CR>", { silent = true, desc = "Show Git window" })
vim.keymap.set("n", "<Leader>tn", function() require("neotest").run.run() end, { silent = true, desc = "Run nearest test" })
vim.keymap.set("n", "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { silent = true, desc = "Run test file" })
-- }}}

-- Abbreivations {{{
vim.cmd("inoreabbrev bi binding.irb")
vim.cmd("inoreabbrev bp binding.pry")
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

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Treesitter highlighting, indentation and incremental selection",
  callback = function(args)
    local parser = vim.treesitter.get_parser(args.buf, nil, { error = false })
    if not parser then
      return
    end

    vim.treesitter.start(args.buf)

    if args.match == "ruby" then
      vim.bo[args.buf].syntax = "ruby"
    elseif vim.treesitter.query.get(parser:lang(), "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local opts = { buffer = args.buf, remap = true, silent = true }
    vim.keymap.set("n", "<Space>", "van", vim.tbl_extend("force", opts, { desc = "Start Treesitter selection" }))
    vim.keymap.set("x", "<Space>", "an", vim.tbl_extend("force", opts, { desc = "Expand Treesitter selection" }))
    vim.keymap.set("x", "<BS>", "in", vim.tbl_extend("force", opts, { desc = "Shrink Treesitter selection" }))
  end
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show LSP diagnostics window on cursor hold",
  pattern = "",
  callback = function()
    vim.diagnostic.open_float(0, { scope = "cursor", focus = false })
  end
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   desc = "Disable semantic highlight provided by LSP servers",
--   pattern = { "ruby" },
--   callback = function(event)
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end
-- })
-- }}}

-- Functions {{{
vim.cmd("command! FormatXML :%!python3 -c 'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'")
-- }}}

-- vim:foldmethod=marker:foldlevel=0
