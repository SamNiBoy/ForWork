" Setting some decent VIM settings for programming

colorscheme samni
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
syntax enable
"syntax on                       " turn syntax highlighting on by default
set number
set list
set cursorline
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white
set ignorecase
set expandtab
set wildmenu
set novisualbell
set hidden
set hlsearch
set tabstop=4
set shiftwidth=8
set nobackup
set nowb
set foldenable
set foldmethod=manual
set clipboard+=unnamed
set noswapfile
set path+=,**,./src,
set grepprg=git\ grep\ -n\ -i
filetype plugin indent on
noremap <C-v> <C-W>v
noremap <C-s> <C-W>s
nnoremap <tab> <C-W><C-W>
noremap lf :! cls & git ls-files \| grep -i 
noremap gp :grep 
noremap co :copen <CR>
noremap cc :cclose <CR>
noremap z1 zfi{<esc>    "folder block with {}
noremap z2 zfi(<esc>
noremap z3 zfi[<esc>
noremap z4 zfap<esc>
noremap gbf :! cls & git blame -- % <CR> "git blame current file
noremap gb :! cls & git blame -- 
noremap gs :! cls & git show 
noremap gsl :! cls & git log --oneline <CR>
noremap gslg :! cls & git log --oneline --graph <CR>

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")
