set clipboard=unnamedplus
unmap <Space>
unmap ;

"""""""""""""""""""""""""""""""
" BASIC REMAPS OF NAIO AND RD "
"""""""""""""""""""""""""""""""

inoremap ;n <Esc>
vnoremap ;n <Esc>

" remap of hjkl to naio
noremap h i
noremap k a
noremap j n
noremap l o

noremap H I
noremap K A
noremap J N
noremap L O

" directions
noremap n h
nnoremap a gk
nnoremap i gj
vnoremap a k
vnoremap i j

noremap o l

" capital directions
nnoremap N mzJ`z
onoremap N H
vnoremap N H

exmap mu m '<-2
nnoremap A <C-u>
vnoremap A :mu<cr>gv=gv
onoremap A K

exmap md m '>+1
nnoremap I <c-d>
vnoremap I :md<cr>gv=gv
onoremap I J

" arrow keys
nnoremap <down> <C-d>
nnoremap <up> <C-u>

" deletion and replacement
noremap d r
noremap r d
noremap D R
noremap R D

""""""""""""""""""
" TAB OPERATIONS "
""""""""""""""""""
exmap tabprev obcommand workspace:previous-tab
exmap tabnext obcommand workspace:next-tab
exmap tabopen obcommand workspace:new-tab
exmap tabclose obcommand workspace:close

nnoremap <Space>tn :tabprev<CR>
nnoremap <Space>to :tabnext<CR>
nnoremap <Space>ts :tabopen<CR>
nnoremap ;n :tabclose<CR>


""""""""""
" SPLITS "
""""""""""
exmap splitdown obcommand workspace:split-horizontal
exmap splitright obcommand workspace:split-vertical

nnoremap <Space>O :splitright<CR>
nnoremap <Space>I :splitdown<CR>

nnoremap <Space>o <S-Right>

"""""""""
" LINKS "
"""""""""
exmap back obcommand app:go-back
exmap forw obcommand app:go-forward

nmap <CR> gf
nnoremap <BS> :back<CR>
nnoremap <S-BS> :forw<CR>
