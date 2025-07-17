call plug#begin()
Plug 'preservim/nerdtree'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'simrat39/rust-tools.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'projekt0n/github-nvim-theme'
call plug#end()

colorscheme github_light 
set tabstop=4
set shiftwidth=4
set number
set laststatus=3
set shiftwidth=4 smarttab
set expandtab

lua << EOF

local rt = require("rust-tools")
--local lsp = require("lspconfig")
local coq = require("coq")

-- lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({}))

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	  -- inlay hints
	  rt.inlay_hints.enable()
    end,
  },
})

EOF

COQnow -s 
autocmd VimEnter * NERDTree
