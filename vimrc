" ViM general settings --- {{{
set number relativenumber nocompatible
set splitright splitbelow
set hlsearch incsearch
set cursorline
set ignorecase smartcase
set wildmenu
set expandtab smarttab
set tags=./.tags;,~/.vimtags
set mouse=a " for collaboration
set background=dark
set tabstop=2
set shiftwidth=2
set scrolloff=2
set updatetime=100
set path+=**
syntax enable
filetype on
filetype plugin on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}

" Airline --- {{{
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '^V' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '^S' : 'S',
      \ }
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '(%l,%c)'
" }}}

let mapleader = ","

" General Mappings and Function Keys --- {{{
map <silent> <F1> :NERDTreeToggle<CR>
map <silent> <F2> :NERDTreeFind<CR>
let g:lt_location_list_toggle_map = '<F3>'
let g:lt_quickfix_list_toggle_map = '<F4>'
nnoremap <silent> <F5> :!osascript -e <c-r>=&ft==?'javascript'? "'tell application ".'"'."Simulator".'"'." to activate' -e 'tell application ".'"'."System Events".'"'." to keystroke ".'"'."r".'"'." using command down' -e 'tell application ".'"'."iTerm".'"'." to activate'" : "'".'tell application "Google Chrome" to tell the active tab of its first window to reload'."'"<cr><cr><cr>
" For backup
" nnoremap <silent> <F5> :w<cr>:!osascript -e 'tell application "Simulator" to activate' -e 'tell application "System Events" to keystroke "r" using command down' -e 'tell application "iTerm" to activate'<cr><cr>

" Clear search highlight and won't retrigger when I open a new file
nnoremap <silent> <F6> :let @/ = ""<cr>
map <silent> <F7> :DBResultsClose<CR>
map <silent> <F9> :TagbarToggle<CR>
map <silent> <F10> :TagbarOpenAutoClose<CR>

command! -bang -nargs=* WA :!osascript ~/Git/whatsapp-applescript/whatsapp.scpt <args>

let g:tagbar_map_help='?'

" Easysplit
nnoremap <silent> <leader>- :new %<cr>
nnoremap <silent> <leader><Bar> :vnew %<cr>

" make j and k work with wraps
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Add , to the end of last line (used after pasting a key-value pair)
nnoremap <leader>, kA,<esc>j

" Highlight
map <leader>hl :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Swap 0 and ^, I don't want going to line start needs shift
onoremap 0 ^
nnoremap 0 ^
onoremap ^ 0
nnoremap ^ 0

" ZZ in insert mode also does ZZ
inoremap ZZ <esc>ZZ

" H and L hacks
nnoremap <expr> H getcurpos()[1] == line("w0") ? "\<PageUp>" : "H"
nnoremap <expr> L getcurpos()[1] == line("w$") ? "\<PageDown>" : "L"

xnoremap <expr> H getcurpos()[1] == line("w0") ? "\<PageUp>" : "H"
xnoremap <expr> L getcurpos()[1] == line("w$") ? "\<PageDown>" : "L"

" As I am mapping the / to do a fuzzy find
nnoremap / /\v

" My unimpaired style add space
nnoremap ]` a<space><esc>
nnoremap [` i<space><esc>

" Jump to tags at the middle of screen
nnoremap <C-]> <C-]>zt

" Paste without linefeed, and paste in Insert with <C+'>
nnoremap <leader>p :let @"=substitute(@", '\v^\s+\|\n+$', '', 'g')<CR>p
inoremap <leader>p <esc>:let @"=substitute(@", '\v^\s+\|\n+$', '', 'g')<CR>pa

" Delete in insert mode
inoremap <C-d> <C-o>x

" No shift anymore for commands
nnoremap ; :

inoremap jk <esc>
inoremap fd <esc>
vnoremap fd <esc>
" I don't like vj being slow (I use vj,se to run SQL)
" vnoremap jk <esc>

inoremap <C-z> <esc>u

nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ei :vsplit ~/.config/nvim/init.vim<cr>
" nnoremap <leader>ws :set listchars=eol:¬,tab:>\ ,trail:~,space:\  list!<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>si :source ~/.config/nvim/init.vim<cr>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -2<CR>
" maths: right is bigger on x-axis
nnoremap <Right> :vertical resize +2<CR>

nnoremap <leader>rl :!osascript -e 'tell application "Google Chrome" to tell the active tab of its first window to reload'<cr><cr>

let @v='//- vim: set ts=2 sw=2 sts=2 et:'

function! GotoBuffer()
  buffers
  let j = input("Please select your buffer: ")
  if j != ''
      execute ":buffer!  " . j
  endif
endfunction
nnoremap ,b :call GotoBuffer()<cr>

" <C-a> is the tmux prefix for me. Mapping <C-q> for increment
nnoremap <C-q> <C-a>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" }}}

" ViM file settings --- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
" }}}

" --- Perl settings ---{{{
" --- Damian Conway's ---{{{
"======[ Magically build interim directories if necessary ]===================

function! AskQuit (msg, options, quit_option)
    if confirm(a:msg, a:options) == a:quit_option
        exit
    endif
endfunction

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
             \       "&Create it\nor &Quit?", 2)

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
        endtry
    endif
endfunction

augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
" --- }}}
" --- }}}

" --- ripgrep --- {{{
" Put search result in the center of screen
nmap n nzz
command! -bang -nargs=* Find call fzf#vim#grep('rg --vimgrep --column --line-number --glob "!vendor/" --glob "!.git/*" --glob "!tags" --glob "!nytprof" --glob "!tmon.out" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindUsage call fzf#vim#grep('rg --vimgrep --column --line-number --glob "!vendor/" --glob "!.git/*" --glob "!tags" --glob "!nytprof" --glob "!tmon.out" --color "always" '.( &ft=='php' ? '--glob "**/*.php" ' : '--glob "**/*.pm" --glob "**/*.cgi" ' ).shellescape(<q-args>), 1, <bang>0)

" find usage since I don't have a good cscope plugin / installation...
nnoremap <leader>fu :FindUsage <C-r><C-w><cr>
set grepprg=rg\ --vimgrep\ --glob\ \"!vendor/\"\ --glob\ \"!.git/*\"\ --glob\ \"!tags\"\ --column\ --line-number\ --no-heading
set grepformat=%f:%l:%c:%m,%f:%l:%m
nnoremap <leader>z :FZF<cr>
" --- }}}

" --- syntastic --- {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" --- }}}

" --- easymotion --- {{{
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <leader>/ incsearch#go(<SID>config_easyfuzzymotion())

" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

nmap <Space> <Plug>(easymotion-bd-f)
omap <Space> <Plug>(easymotion-bd-f)
nmap <Leader><Space> <Plug>(easymotion-overwin-f)
" Move to line
map `` <Plug>(easymotion-bd-jk)
nmap `` <Plug>(easymotion-overwin-line)

" Move to word
map <leader>w <Plug>(easymotion-bd-w)
" }}}

" --- wiki.vim --- {{{
let g:wiki_root='~/private/gdrive/My Drive/Self reference/wiki'
let g:wiki_zotero_root='~/private/gdrive/My Drive/Self reference/reference'
let g:wiki_template_title_month='# %(year) %(month-name)'
let g:wiki_template_title_week='# %(year) week %(week)'
let g:wiki_filetypes=['md']
let g:wiki_date_exe='gdate'
let g:wiki_tags_format_pattern='\v%(^|\s)#\zs[^# ]+'
let g:wiki_list_todos= ['TODO', 'DOING', 'DONE']

let g:wiki_map_link_create = 'LinkNameScheme'

function LinkNameScheme(text) abort
  return substitute(tolower(a:text), '\s\+', '_', 'g')
endfunction

" [Add date]
nmap <silent> <leader>date a<C-R>=strftime(" %a %d %b %Y %I:%M:%S %p %Z")<CR><ESC>

" Copy to next journal
nnoremap <silent> <leader>wj :WikiJournalCopyToNext<CR>

" From:
" - https://www.reddit.com/r/vim/comments/2hxxxy/how_to_autoupdate_time_stamp_field_in_a_file/
" - https://gist.github.com/jelera/7838011
autocmd! BufWritePre ~/private/gdrive/* :call s:timestamp()

" [To update timestamp when saving if its in the first 20 lines of a file]
function! s:timestamp()
    let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
    let rep = '\1' . strftime("%a %d %b %Y %I:%M:%S %p %Z")
    call s:subst(1, 20, pat, rep)
endfunction

" subst( start, end, pat, rep): substitute on range start - end.
function! s:subst(start, end, pat, rep)
    let lineno = a:start
    while lineno <= a:end
        let curline = getline(lineno)
        if match(curline, a:pat) != -1
            let newline = substitute( curline, a:pat, a:rep, '' )
            if( newline != curline )
                " Only substitute if we made a change
                "silent! undojoin
                keepjumps call setline(lineno, newline)
            endif
        endif
        let lineno = lineno + 1
    endwhile
endfunction
" }}}

" Global plugin variables --- {{{
let g:neotags_enabled = 0
let g:neotags_run_ctags = 0
let g:neotags#perl#order = 's'
let g:feature_filetype = 'behat'
let g:AutoPairsFlyMode = 1

let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
  \ }

let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[""]
let g:UltiSnipsEditSplit="vertical"
let g:wordmotion_prefix = '<Leader>'
" }}}

" filetype hacks --- {{{
" Auto remap arrows for Fugitive
:augroup fugitive_arrows
:  autocmd FileType fugitive nmap <Down> <C-N>
:  autocmd FileType fugitive nmap <Up> <C-P>
:augroup END

" Auto enter insert mode when typing git commit messages
:augroup gitcommit_insert
:  autocmd BufWinEnter COMMIT_EDITMSG :startinsert
:augroup END
" }}}

" vim-plug --- {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" Any valid git URL is allowed
Plug 'FooSoft/vim-argwrap'
Plug 'MarSoft/nerdtree-grep-plugin', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
" Plug 'SirVer/ultisnips'
" Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'Valloric/ListToggle'
Plug 'airblade/vim-gitgutter'
" Plug 'c0r73x/neotags.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'chaoren/vim-wordmotion'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-titlecase'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
" Plug 'elmcast/elm-vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'jceb/vim-orgmode'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-peekaboo'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'lervag/wiki.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'micha/vim-colors-solarized'
" Plug 'nicwest/QQ.vim' " for db connection
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-fubitive'
Plug 'tommcdo/vim-ninja-feet'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-php/tagbar-phpctags.vim'
" Plug 'vim-scripts/dbext.vim'
" Plug 'vim-syntastic/syntastic'
Plug 'vimtaku/vim-textobj-keyvalue'
Plug 'wellle/targets.vim'
Plug 'xolox/vim-misc'

if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " coc... finally
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

if has('win32') || has('win64')
    Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
  else
    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

" Initialize plugin system
call plug#end()
" }}}

" FZF settings --- {{{
" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" }}}

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" brew install python3 https://github.com/Shougo/deoplete.nvim
" call deoplete#enable()
" let g:deoplete#enable_at_startup = 1

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Shifting delete operator --- {{{
function! ShiftingDeleteOperator(type)
  let reg_dict = {}
  for k in range(1, 8)
    execute printf("let reg_dict[%d]=getreg('%d', 1)", k, k)
  endfor

  if a:type ==# 'v'
    execute 'normal! `<v`>d'
  elseif a:type ==# 'V'
    execute 'normal! `<V`>d'
  elseif a:type ==# "\<C-V>"
    execute "normal! `<\<C-V>`>d"
  elseif a:type ==# 'char'
    execute 'normal! `[v`]d'
  elseif a:type ==# 'line'
    execute "normal! '[V']d"
  else
    return
  endif

  let deleted = getreg('"', 1)
  call setreg(1, deleted)

  for [k, v] in items(reg_dict)
    execute printf("call setreg(%d, v)", k + 1)
  endfor
endfunction

" Call the function for d{motion} via operatorfunc
nnoremap <silent> d :set operatorfunc=ShiftingDeleteOperator<CR>g@
" Call the function when d or x are hit in visual mode
vnoremap d :<C-U>call ShiftingDeleteOperator(visualmode())<CR>
vnoremap x :<C-U>call ShiftingDeleteOperator(visualmode())<CR>
" Use the d{motion} as defined above to add limited support for `D` command
nmap D d$
" Use the standard dd command
nnoremap dd dd
" }}}

" B with fallback --- {{{
" https://vi.stackexchange.com/questions/15964/how-to-add-a-fallback-when-b-buffer-change-fails
function! BWithFallback(buffer_name) abort
  " Check if the input is a number or a string
  if a:buffer_name =~# '^\d\+$'
    execute 'b' a:buffer_name
  else
    try
      " Try opening the buffer
      execute 'b' a:buffer_name
    catch /E94/
      " If the buffer didn't exist, try doing a fuzzy file search
      " using the command provided by the OP.
      execute 'FZF -q' a:buffer_name
    endtry
  endif
endfunction

" Create new :B command. You could also use -complete=file if you prefer
command! -nargs=1 -complete=buffer B call BWithFallback('<args>')

" When you type :b, replace it with :B
cnoreabbrev <expr> b (getcmdtype() == ':' && getcmdline() ==# 'b') ? 'B' : b
" }}}

" gJ to remove prefix spaces and leader to preserve --- {{{
" Like gJ, but always remove spaces
fun! JoinSpaceless()
    execute 'normal! gJ'

    " Character under cursor is whitespace?
    if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
        " When remove it!
        execute 'normal! dw'
    endif
endfun

" Map it to a key
nnoremap gJ :call JoinSpaceless()<CR>
nnoremap <Leader>J :normal! gJ<CR>
" }}}

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  " Put this in your .vimrc to create an undodir if it doesn't exist and enable persistent undo. Tested on both Windows and Linux.
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo
endif

colorscheme solarized

