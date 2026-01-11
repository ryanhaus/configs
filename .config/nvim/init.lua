-- Vim options
vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.laststatus = 3

vim.opt.updatetime = 250

-- Plugins
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "c",
                "cpp",
                "rust",
                "python",
                "verilog",
                "systemverilog",
                "lua",
            },
            highlight = { enable = true },
        },
    },

    -- Error highlighting / LSP
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "rust_analyzer",
                "pyright",
                "svlangserver",
                "lua_ls",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("clangd", {})
            vim.lsp.config("rust_analyzer", {})
            vim.lsp.config("pyright", {})
            vim.lsp.config("svlangserver", {})

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- to resolve 'Undefined global vim'
                        },
                    },
                },
            })
        end,
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                -- Setup so tab = go down, shift+tab = go up, enter = select
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s"}),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_selected_entry() then
                            cmp.confirm({ select = false })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                sources = {
                    { name = "nvim_lsp" },
                },
            })
        end,
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({})

            -- set keybinds
            vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
            vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
            vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    	end,
    },

    -- Error browsing
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
            },
        },
    },

    -- For remembering keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
            },
        },
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
    },

    -- Theme (gruvbox)
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {}
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons", opts = {} },
})

-- Auto show errors when hovering over
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
        })
    end,
})

-- Configure autocomplete to not automatically select anything
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Configure nvim-tree
require("nvim-tree").setup({
    hijack_cursor = true,
    update_cwd = true,
    view = {
        width = 30,
        side = "left",
    },
})

--[[
-- Open tree on nvim startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p") -- Move cursor back to buffer, not tree
    end
})

-- Close tree on last buffer close
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
            vim.cmd "quit"
        end
    end
})
]]

-- Configure theme (gruvbox)
require("gruvbox").setup({
    -- contrast = "hard",
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
