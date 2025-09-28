" Vim compiler file
" Compiler: nx lint with ESLint
" Maintainer: Cherry Ramatis

if exists("current_compiler")
  finish
endif
let current_compiler = "nxlint"

" Set the make program
setlocal makeprg=npx\ nx\ affected:lint\ --nx-bail\ --base=$NX_BASE\ --head=$NX_HEAD\ --format=compact

" Set error format to parse nx/eslint output
setlocal errorformat=
    \%f:\ line\ %l\\,\ col\ %c\\,\ %t%*[^\ ]\ -\ %m,
    \%f:\ line\ %l\\,\ col\ %c\\,\ %m,
    \%-G%.%#✔%.%#,
    \%-G%.%#✖%.%#,
    \%-G%.%#———%.%#,
    \%-G%.%#NX%.%#,
    \%-G%.%#>%.%#,
    \%-G%.%#Warning:%.%#,
    \%-G%.%#With\ additional\ flags:%.%#,
    \%-G%.%#succeeded%.%#,
    \%-G%.%#targets\ failed%.%#,
    \%-G%.%#error\ Command\ failed%.%#,
    \%-G%.%#info\ Visit%.%#,
    \%-G%.%#λ%.%#,
    \%-G^$

