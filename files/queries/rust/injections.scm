; Inject into sql::query!(r#"..."#, ..) as sql
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

  (token_tree
    (raw_string_literal) @sql))

; Inject into sql::query!("...", ..) as sql
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

  (token_tree
    (string_literal) @sql))
