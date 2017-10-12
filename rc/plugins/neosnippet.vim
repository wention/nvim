" Plugin Configuration
"
" for 'Shougo/neosnippet.vim'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#expand_word_boundary = 1

" let g:snippets_dir = '~/.vim/snippets/,~/.vim/bundle/snipmate/snippets/'
let g:neosnippet#snippets_directory = '~/.config/nvim/rc/snippets'

inoremap <silent> (( <C-r>=neosnippet#anonymous('\left(${1}\right)${0}')<CR>
