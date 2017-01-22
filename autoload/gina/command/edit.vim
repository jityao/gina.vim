let s:Argument = vital#gina#import('Argument')


function! gina#command#edit#define() abort
  return s:command
endfunction


" Instance -------------------------------------------------------------------
let s:command = {}

function! s:command.command(range, qargs, qmods) abort
  let git = gina#core#get()
  let args = s:build_args(git, a:qargs)
  let bufname = args.params.path
  let selection = gina#util#selection#from(
        \ bufname,
        \ args.params.selection,
        \)
  call gina#util#buffer#open(bufname, {
        \ 'group': args.params.group,
        \ 'opener': args.params.opener,
        \ 'selection': selection,
        \})
endfunction


" Private --------------------------------------------------------------------
function! s:build_args(git, qargs) abort
  let args = s:Argument.new(a:qargs)
  let args.params = {}
  let args.params.group = args.pop('--group', '')
  let args.params.opener = args.pop('--opener', 'edit')
  let args.params.selection = args.pop('--selection', '')
  let args.params.path = gina#util#abspath(
        \ gina#util#expand(get(args.residual(), 0, '%'))
        \)
  return args.lock()
endfunction
