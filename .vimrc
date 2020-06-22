set nocompatible
syntax on
set encoding=utf8

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
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jiangmiao/auto-pairs'
Plugin '907th/vim-auto-save'

" Git Support
Plugin 'kablamo/vim-git-log'
Plugin 'gregsexton/gitv'
Plugin 'tpope/vim-fugitive'

" Themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Intellisense like
Bundle 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'mattn/emmet-vim'

" Syntax 
Plugin 'mboughaba/i3config.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5-syntax.vim'


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

"""""" Show linenumbers
set number
set ruler


"""""" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab


"""""" Bar Settings
set laststatus=2


"""""" Python Settings
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let python_highlight_all=1

"""""" JavaScript Settigns
let g:javascript_plugin_jsdoc = 1


"""""" You complete me settings
" The first line ensures that the auto-complete window goes away when you’re done with it, and the second defines a shortcut for goto definition.
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""" Emmet Settings
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key=','


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


