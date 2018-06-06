" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" Environment {
	" Identify platform {
        silent function! IsOSX()
            return has('macunix')
        endfunction
        silent function! IsLinux()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! IsWindows()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
	" }

    " Basics {
        set nocompatible        " Must be first line
        if !IsWindows()
            set shell=/bin/sh
        endif

        " Be nice and check for multi_byte even if the config requires
        " multi_byte support most of the tim" multi_byte support most of the timee
        if has("multi_byte")
            " Windows cmd.exe still uses cp850. If Windows ever moved to
            " Powershell as the primary terminal, this would be utf-8
            set termencoding=cp850
            " Let Vim use utf-8 internally, because many scripts require this
            set encoding=utf-8
            setglobal fileencoding=utf-8
            " Windows has traditionally used cp1252, so it's probably wise to
            " fallback into cp1252 instead of eg. iso-8859-15.
            " Newer Windows files might contain utf-8 or utf-16 LE so we might
            " want to try them first.
            set fileencodings=ucs-bom,utf-8,gbk,gb2312,cp936
        endif

        augroup MyAutoCmd
        let mapleader = ','
        let maplocalleader = '_'
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if IsWindows()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }
" }

" Plugins {
    set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

    call dein#begin(expand('~/.config/nvim/dein')) " plugins' root path

    " General {
        call dein#add('Shougo/dein.vim')
        call dein#add('Shougo/vimproc.vim', {
                        \ 'build': 'make',
                        \ })

        call dein#add('Shougo/context_filetype.vim')

        call dein#add('iequalsraf/neovim-gui-shim')

        call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

        call dein#add('scrooloose/nerdtree', {
                        \ 'depends': ['vim-nerdtree-syntax-highlight'],
                        \ 'on_cmd': ['NERDTreeToggle', 'NERDTreeFind'],
                        \ 'hook_add': 'nnoremap <leader>e :NERDTreeToggle<CR>
                        \             nnoremap <leader>ef :NERDTreeFind<CR>',
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/nerdtree.vim',
                        \ })


        "call dein#add('tpope/vim-obsession')
        call dein#add('tpope/vim-surround')
        call dein#add('ctrlpvim/ctrlp.vim')
        call dein#add('tpope/vim-repeat')

        call dein#add('vim-airline/vim-airline', {
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/vim-airline.vim',
                        \ })
        call dein#add('vim-airline/vim-airline-themes')

        call dein#add('mbbill/undotree', {
                        \ 'on_cmd': 'UndotreeToggle',
                        \ 'hook_add': 'nnoremap <Leader>u :UndotreeToggle<CR>',
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/undotree.vim',
                        \ })

        call dein#add('mhinz/vim-signify')
        call dein#add('Yggdroot/indentLine', {
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/indentLine.vim',
                        \ })

        call dein#add('ryanoasis/vim-devicons')

        call dein#add('Shougo/vimshell.vim', {
                        \ 'on_map': {'n': '<Plug>'},
                        \ 'hook_add': 'nnoremap <leader>s <Plug>(vimshell_switch)',
                        \ })

        call dein#add('easymotion/vim-easymotion')
        "call dein#add('myusuf3/numbers.vim')

        call dein#add('benmills/vimux')
    " }

    " Common Code {
        call dein#add('scrooloose/syntastic', {
                        \ 'if': '1',
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/syntastic.vim',
                        \ })

        call dein#add('tpope/vim-fugitive')
        call dein#add('majutsushi/tagbar', {
                        \ 'on_cmd': [ 'TagbarToggle', 'TagbarOpen'],
                        \ 'hook_add': 'nnoremap <leader>t :TagbarToggle<CR>'
                        \ })

        call dein#add('Shougo/neosnippet-snippets')
        call dein#add('Shougo/neosnippet.vim',{
                        \ 'depends': ['context_filetype.vim', 'neosnippet-snippets'],
                        \ 'on_ft': 'snippet',
                        \ 'on_event': 'InsertCharPre',
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/neosnippet.vim',
                        \ })

        call dein#add('Shougo/deoplete.nvim', {
                        \ 'depends': 'context_filetype.vim',
                        \ 'if': 'has("nvim")',
                        \ 'on_event': 'InsertEnter',
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/deoplete.vim',
                        \ })

        call dein#add('kristijanhusak/vim-multiple-cursors')
        call dein#add('junegunn/vim-easy-align')
        call dein#add('vim-scripts/matchit.zip')
        call dein#add('mhinz/vim-startify')
        call dein#add('scrooloose/nerdcommenter')
        call dein#add('mileszs/ack.vim', {
                        \ 'on_cmd': ['Ack'],
                        \ })

        " for python
        call dein#add('zchee/deoplete-jedi', {
                        \ 'depends': 'deoplete.nvim',
                        \ 'on_ft': 'python',
                        \ })

        " for c/c++
        call dein#add('zchee/deoplete-clang', {
                        \ 'depends': 'deoplete.nvim',
                        \ 'on_ft': ['c', 'cpp'],
                        \ 'hook_source': 'source ~/.config/nvim/rc/plugins/deoplete-clang.vim',
                        \ })

        " for golang
        call dein#add('zchee/deoplete-go', {
                        \ 'depends': 'deoplete.nvim',
                        \ 'on_ft': 'go',
                        \ })

        " for qt
        call dein#add('peterhoeg/vim-qml', {
                        \ 'on_ft': ['qml'],
                        \ })

        " for web
        call dein#add('posva/vim-vue', {
                        \ 'on_ft': ['vue'],
                        \ })

    " }


    if dein#tap('deoplete.nvim') && has('nvim')
        call dein#disable('neocomplete.vim')
    endif
    call dein#disable('neobundle.vim')
    call dein#disable('neopairs.vim')

    call dein#end()

    if has('vim_starting')
        call dein#call_hook('source')
        call dein#call_hook('post_source')
    endif
" }

" General {
    set background=dark         " Assume a dark background

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    set history=1000                    " Store a ton of history (default is 20)

    if has("autocmd")  " go back to where you exited
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal g'\"" |
            \ endif
    endif

    " Use clipboard register.
    if (has('nvim') || $DISPLAY != '') && has('clipboard')
        set clipboard+=unnamedplus
    endif

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

" }

" NVIM UI {
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
    set termguicolors               " Enable 24-bit color
    colorscheme badwolf

    " setup guifont
    "if has('gui_running')
        "if IsLinux()
    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Plus\ Nerd\ File\ Types\ 14
        "endif
    "endif
    "let g:Guifont="Ubuntu Mono derivative Powerline Plus Nerd File Types:h14"

    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    set number                      " Line numbers on

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_spf13_bundles')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

" }

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns

    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" }

" Key (re)Mappings {
    nmap <C-H> <C-W>h
    nmap <C-J> <C-W>j
    nmap <C-K> <C-W>k
    nmap <C-L> <C-W>l

    nnoremap <F3> :NumbersToggle<CR>
    nnoremap <F4> :NumbersOnOff<CR>

    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    " disable Ex mode
    map Q <Nop>
" }
