return {
    cmd = {"ocamllsp"},
    filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
    root_markers = {"dune-project", ".git"},
    settings = {
        extendedHover = {enable = true},
        standardHover = {enable = true},
        codelens = {enable = true},
        duneDiagnostics = {enable = true},
        inlayHints = {
            hintPatternVariables = true,
            hintLetBindings = true,
            hintFunctionParams = true
        },
        syntaxDocumentation = {enable = true},
        merlinJumpCodeActions = {enable = true}
    }
}
