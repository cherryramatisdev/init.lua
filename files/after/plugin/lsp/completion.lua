vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local lspkind = require("lspkind")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
		["<C-o>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "emmet_vim" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		-- { name = "buffer" },
		{ name = "path" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})
