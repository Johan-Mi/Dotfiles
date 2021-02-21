" =============================================================================
" Filename: autoload/lightline/colorscheme/modeline.vim
" Author: Johan Milanov
" License: MIT License
" Last Change:
" =============================================================================

" Common colors
let s:blue   = [ '#61afef', 75 ]
let s:green  = [ '#98c379', 2 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#be5046', 168 ]
let s:yellow = [ '#e5c07b', 180 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:fg    = [ '#abb2bf', 145 ]
let s:bg    = [ '#0B0B0B', 233 ]
let s:gray1 = [ '#5c6370', 241 ]
let s:gray2 = [ '#020202', 233 ]
let s:gray3 = [ '#121212', 240 ]
let s:gray4 = [ '#808080', 244 ]

let s:p.inactive.left   = [ [ s:gray1,  s:bg ], [s:yellow, s:bg ], [ s:gray1, s:bg ] ]
let s:p.inactive.middle = [ [ s:gray1, s:bg ], [ s:gray1, s:bg ] ]
let s:p.inactive.right  = [ [ s:gray1, s:bg ], [ s:gray1, s:bg ] ]

" Common
let s:p.normal.left    = [ [ s:green, s:bg ], [s:yellow, s:bg ], [ s:fg, s:bg, 'bold' ] ]
let s:p.normal.middle  = [ [ s:fg, s:bg ], [ s:fg, s:bg ] ]
let s:p.normal.right   = [ [ s:blue, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.normal.error   = [ [ s:red2, s:bg ] ]
let s:p.normal.warning = [ [ s:yellow, s:bg ] ]
let s:p.insert.right   = [ [ s:blue, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.insert.left    = [ [ s:blue, s:bg ], [s:yellow, s:bg ], [ s:fg, s:bg, 'bold' ] ]
let s:p.replace.right  = [ [ s:blue, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.replace.left   = [ [ s:red1, s:bg ], [s:yellow, s:bg ], [ s:fg, s:bg, 'bold' ] ]
let s:p.visual.right   = [ [ s:blue, s:bg, 'bold' ], [ s:fg, s:bg ] ]
let s:p.visual.left    = [ [ s:yellow, s:bg ], [s:yellow, s:bg ], [ s:fg, s:bg, 'bold' ] ]
let s:p.tabline.left   = [ [ s:gray4, s:bg ] ]
let s:p.tabline.tabsel = [ [ s:fg, s:gray3, 'bold' ] ]
let s:p.tabline.middle = [ [ s:fg, s:gray2 ] ]
let s:p.tabline.right  = copy(s:p.normal.right)

let g:lightline#colorscheme#modeline#palette = lightline#colorscheme#flatten(s:p)
