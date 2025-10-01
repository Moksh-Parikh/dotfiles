local Plug = vim.fn["plug#"]
vim.call("plug#begin")
	Plug("nvim-treesitter/nvim-treesitter")
	Plug("tpope/vim-commentary")
	
	Plug("hrsh7th/cmp-buffer")
	Plug("hrsh7th/cmp-path")
	Plug("hrsh7th/cmp-cmdline")
	Plug("hrsh7th/nvim-cmp")
	Plug("hrsh7th/cmp-nvim-lsp")
	
	Plug("L3MON4D3/LuaSnip", {["tag"] = "v2.*", ["do"] = "make install_jsregexp"})
	Plug("saadparwaiz1/cmp_luasnip")
	
	Plug("norcalli/nvim-colorizer.lua")
	
	Plug("itchyny/lightline.vim")
	
	Plug("slugbyte/lackluster.nvim")
	
	Plug("preservim/nerdtree")
	
	Plug("HiPhish/rainbow-delimiters.nvim")
	
	Plug("AndrewRadev/tagalong.vim")
	Plug("tpope/vim-surround")
	
	Plug("sphamba/smear-cursor.nvim")
	
	Plug("neovim/nvim-lspconfig")
vim.call("plug#end")

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.showmode = false
vim.o.cursorline = true
vim.o.number = true
vim.o.autowrite = true

vim.g.lightline = {
    colorscheme = "ayu_mirage",
    active = {
        left = {
            {"mode", "paste"},
            {"readonly", "filename", "modified"}
        }
    },
    component = {
        lineinfo = "%{line('.') .. '/' .. line('$')}"
    }
}

vim.cmd("colorscheme lackluster-mint")

vim.keymap.set("n", "<C-o>", ":source Session.vim<CR><CR>", {silent = true})
vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>", {silent = true})
vim.keymap.set("n", "Y", "^y$<CR>", {silent = true})
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "mk", ":make<CR>", {silent = true})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.cmd [[
	set filetype
	imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
	inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
    set shellxquote=
	set shell=powershell
	let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
	let &shellquote   = ''
	let &shellpipe    = '> %s'
	let &shellredir   = '> %s'
]]

require "nvim-treesitter.configs".setup {highlight = {enable = true}, indent = {enable = true}}
require "nvim-treesitter.install".compilers = {"zig"}
require "colorizer".setup {"css", "javascript", "json", html = {mode = "foreground"}}
require("smear_cursor").setup()

local cmp = require "cmp"

local luasnip = require("luasnip")
luasnip.setup()

luasnip.add_snippets("c", require(("c-snippets")))

-- for header files, because vim thinks its cpp
luasnip.add_snippets("cpp", require(("c-snippets")))

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true})
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "luasnip"}
            },
            {
                {name = "buffer"}
            },
			{
                {name = "nvim_lsp"}
            }
        )
    }
)

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    {"/", "?"},
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        ),
        matching = {disallow_symbol_nonprefix_matching = false}
    }
)

vim.lsp.enable("emmet_language_server")
-- vim.lsp.config(, {})
-- , {
  -- filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
  -- -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- -- **Note:** only the options listed in the table are supported.
  -- init_options = {
    -- ---@type table<string, string>
    -- includeLanguages = {},
    -- --- @type string[]
    -- excludeLanguages = {},
    -- --- @type string[]
    -- extensionsPath = {},
    -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    -- preferences = {},
    -- --- @type boolean Defaults to `true`
    -- showAbbreviationSuggestions = true,
    -- --- @type "always" | "never" Defaults to `"always"`
    -- showExpandedAbbreviation = "always",
    -- --- @type boolean Defaults to `false`
    -- showSuggestionsAsSnippets = false,
    -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    -- syntaxProfiles = {},
    -- --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    -- variables = {},
  -- },
-- })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
  -- pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
  -- callback = function()
    -- vim.lsp.start({
      -- cmd = { "emmet-language-server", "--stdio" },
      -- root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      -- -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- -- **Note:** only the options listed in the table are supported.
      -- init_options = {
        -- ---@type table<string, string>
        -- includeLanguages = {},
        -- --- @type string[]
        -- excludeLanguages = {},
        -- --- @type string[]
        -- extensionsPath = {},
        -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        -- preferences = {},
        -- --- @type boolean Defaults to `true`
        -- showAbbreviationSuggestions = true,
        -- --- @type "always" | "never" Defaults to `"always"`
        -- showExpandedAbbreviation = "always",
        -- --- @type boolean Defaults to `false`
        -- showSuggestionsAsSnippets = false,
        -- --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        -- syntaxProfiles = {},
        -- --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        -- variables = {},
      -- },
    -- })
  -- end,
-- })