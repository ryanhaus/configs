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
vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')

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
                "markdown",
                "markdown_inline",
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
                "marksman",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("clangd", {})
            vim.lsp.config("rust_analyzr", {})
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

            vim.keymap.set('n', '<leader>h', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { bufnr = 0 })
            end, { desc = 'Toggle LSP Inlay Hints' })
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
            vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
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

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- Undo tree
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" }
        },
    },

    -- Search & jump labels
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },

    -- Help learn/visualize movement commands
    {
        "tris203/precognition.nvim",
        opts = {
            startVisible = false
        }
    },

    -- Better w, e, b movements
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
	    keys = {
	    	{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
	    	{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
	    	{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
	    	{ "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
	    },
    },

    -- Integration with zellij and better window navigation
    {
        "swaits/zellij-nav.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",    { silent = true, desc = "navigate left or tab"  } },
            { "<c-j>", "<cmd>ZellijNavigateDown<cr>",       { silent = true, desc = "navigate down"         } },
            { "<c-k>", "<cmd>ZellijNavigateUp<cr>",         { silent = true, desc = "navigate up"           } },
            { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>",   { silent = true, desc = "navigate right or tab" } },
        },
        opts = {},
    }
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

-- rust_analyzer config
vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                typeHints = { enable = true },
                parameterHints = { enable = true },
                chainingHints = { enable = true},
            },
        },
    },
})

-- Keep track of undo history in a file
vim.opt.undofile = true
