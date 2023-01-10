" Need to add the node_modules path in order to load packages
" But you will to use the old import syntax (require)
" because the actual node REPL can't use the ES6 import syntax
let g:codi#command_prefix = [ 'env', 'NODE_PATH=node_modules']
