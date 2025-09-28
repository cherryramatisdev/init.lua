---@brief
---
---@type vim.lsp.Config
return {
    cmd = { 'expert' },
    filetypes = { 'elixir', 'eelixir' },
    root_markers = {
        'mix.exs',
        '.git',
    },
}
