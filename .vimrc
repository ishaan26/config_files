set nocompatible
syntax on
set encoding=utf8
set clipboard+=unnamedplus

" set mouse recording
set mouse=a

"""""""""""""""""""""""""""""""""
"""     Vundle Config 
"""""""""""""""""""""""""""""""""

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


""""""""" Plugins """"""""""

" Utility
Plugin 'vim-syntastic/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin '907th/vim-auto-save'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mbbill/undotree'

" Git Support
Plugin 'kablamo/vim-git-log'
Plugin 'airblade/vim-gitgutter'

" Themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Intellisense like
Bundle 'Valloric/YouCompleteMe'

" Rust 
Plugin 'rust-lang/rust.vim'
Plugin 'arzg/vim-rust-syntax-ext'

" Syntax 
Plugin 'mboughaba/i3config.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'ap/vim-css-color'
Plugin 'luochen1990/rainbow'
Plugin 'preservim/nerdcommenter'
Plugin 'wolfgangmehner/lua-support'
Plugin 'nvie/vim-flake8'

" Nerd Tree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" Color Schemes
Plugin 'joshdick/onedark.vim'
Plugin 'rakr/vim-one'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

autocmd BufEnter * :syntax sync fromstart

"""""""""""""""""""""""""""""""""""""
"""" END Vundle Configuration 
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
"""" Configuration Section
"""""""""""""""""""""""""""""""""""""

"""""" UI Settings
set number
set ruler
set laststatus=2
set wildmenu
set title
set background=dark
let python_highlight_all=1

"""""" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent 
set linebreak


"""""" Undo Dir
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"""""" Window Navigation with Ctrl-[hjkl]
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

"""""" You complete me settings
" The first line ensures that the auto-complete window goes away when you’re done with it, and the second defines a shortcut for goto definition.
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <C-g>  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"""""" NerdTree Settings 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


"""""""""" Rainbow Brackets
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"""""""""" Nerd Commenter 
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"""""""""" set syntax for files with odd extensions
autocmd BufNewFile,BufRead *.rasi set syntax=css

"""""""""" Set Color scheme
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
let g:airline_theme='onedark'
