set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" ==============================================================================
" БАЗОВЫЕ НАСТРОЙКИ WINDOWS
" ==============================================================================
set encoding=utf-8
set fileencodings=utf-8,cp1251 " Поддержка кириллицы
set nocompatible

" ==============================================================================
" ПЛАГИНЫ (vim-plug)
" ==============================================================================
call plug#begin('~/vimfiles/plugged')

" --- Тема оформления ---
Plug 'ghifarit53/tokyonight-vim'
Plug 'itchyny/lightline.vim'            " Красивая статусная строка внизу

" --- Навигация и поиск ---
Plug 'preservim/nerdtree'               " Дерево файлов
Plug 'ctrlpvim/ctrlp.vim'               " Быстрый поиск файлов (идеально для Win)

" --- Синтаксис и Языки ---
Plug 'sheerun/vim-polyglot'             " Пакет синтаксисов (Python, TS, JS, etc.)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Специфичные фичи для Go

" --- LSP и Автодополнение ---
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Главный движок автодополнения

" --- Git ---
Plug 'airblade/vim-gitgutter'           " Изменения Git в левой колонке
Plug 'tpope/vim-fugitive'               " Интеграция с Git

" --- Удобства ---
Plug 'jiangmiao/auto-pairs'             " Автозакрытие скобок
Plug 'preservim/nerdcommenter'          " Быстрое комментирование строк

call plug#end()

" ==============================================================================
" ТЕМА TOKYO NIGHT
" ==============================================================================
set termguicolors
let g:tokyonight_style = 'night'        " Доступны: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" Настройка Lightline под Tokyo Night
let g:lightline = {'colorscheme': 'tokyonight'}

" ==============================================================================
" НАСТРОЙКИ РЕДАКТОРА
" ==============================================================================
syntax on
set number                              " Показывать номера строк
set relativenumber                      " Относительные номера (удобно для прыжков)
set cursorline                          " Подсветка текущей строки
set expandtab                           " Табы пробелами
set tabstop=4                           " Размер таба
set shiftwidth=4                        " Размер отступа
set smartindent                         " Умные отступы
set autoindent                          " Автоотступ
set nowrap                              " Не переносить длинные строки
set hlsearch                            " Подсвечивать поиск
set incsearch                           " Искать по мере ввода
set ignorecase                          " Игнор регистра при поиске...
set smartcase                           " ...если нет заглавных букв
set updatetime=300                      " Быстрое обновление (для gitgutter и coc)
set signcolumn=yes                      " Всегда показывать колонку слева (ошибки/git)
set clipboard=unnamedplus               " Использовать буфер обмена Windows

" ==============================================================================
" СПЕЦИФИЧНЫЕ НАСТРОЙКИ ЯЗЫКОВ
" ==============================================================================
" JS/TS (2 пробела отступа по стандарту)
autocmd FileType javascript,typescript,javascriptreact,typescriptreact setlocal shiftwidth=2 tabstop=2

" Go (Автоформатирование и импорты при сохранении)
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" ==============================================================================
" ГОРЯЧИЕ КЛАВИШИ (Keybindings)
" ==============================================================================
let mapleader = " "                     " Клавиша Leader — Пробел

" Быстрые действия
nnoremap <C-w> :w<CR>                   " Ctrl + w -> Сохранить файл
nnoremap <C-q> :q<CR>                   " Ctrl + q -> Выйти из Vim

" NERDTree (Файловое дерево)
nnoremap <C-e> :NERDTreeToggle<CR>      " Ctrl + e -> Открыть/закрыть дерево
nnoremap <C-f> :NERDTreeFind<CR>        " Ctrl + f -> Найти текущий файл в дереве

" CtrlP (Поиск файлов)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let &t_SI = "\e[6 q"                    " Insert режим: вертикальная линия
let &t_EI = "\e[2 q"                    " Normal режим: классический блок
let &t_SR = "\e[4 q"                    " Replace режим: подчеркивание

" ==============================================================================
" НАСТРОЙКИ COC.NVIM (Автодополнение и навигация по коду)
" ==============================================================================
" Использовать Tab и Shift-Tab для навигации по меню автодополнения
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  ~# '\s'
endfunction

" GoTo навигация по коду
nmap <silent> gd <Plug>(coc-definition)      " gd -> Перейти к определению
nmap <silent> gy <Plug>(coc-type-definition) " gy -> Перейти к определению типа
nmap <silent> gi <Plug>(coc-implementation)  " gi -> Перейти к реализации
nmap <silent> gr <Plug>(coc-references)      " gr -> Найти все использования
