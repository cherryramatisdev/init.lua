vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
}, { load = true })

local ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not ok then
    return
end

treesitter.setup {
    ensure_installed = {"lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"},
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
            },
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next = {
                ["]f"] = '@function.outer',
                ["]b"] = '@block.outer',
            },
            goto_previous = {
                ["[f"] = '@function.outer',
                ["[b"] = '@block.outer',
            }
        }
    }
}
