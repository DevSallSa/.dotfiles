" Show blame only on Workspaces folder
" autocmd BufEnter */Workspaces/** GitBlameEnable

" Enable git blame on startup
let g:gitblame_enabled = 1

" Date format
let g:gitblame_date_format = '%r'

" Specify the highlight group used for the virtual text ('Comment' by default)
let g:gitblame_highlight_group = "Comment"

" Show blame info in virtual text
let g:gitblame_display_virtual_text = 0

" Change message when content is not committed
" let g:blameLineMessageWhenNotYetCommited = ''
let g:gitblame_message_when_not_committed = 'Oh please, commit this !'

" Customize format for git blame 
" (Default format: ' <author> • <date> • <summary>')
let g:gitblame_message_template = '<summary> • <date> • <author>'
