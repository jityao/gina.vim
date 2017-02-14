function! gina#action#compare#define(binder) abort
  call a:binder.define('compare', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': {},
        \})
  call a:binder.define('compare:above', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': { 'opener': 'leftabove new' },
        \})
  call a:binder.define('compare:below', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': { 'opener': 'belowright new' },
        \})
  call a:binder.define('compare:left', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': { 'opener': 'leftabove vnew' },
        \})
  call a:binder.define('compare:right', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': { 'opener': 'belowright vnew' },
        \})
  call a:binder.define('compare:tab', function('s:on_compare'), {
        \ 'description': 'Compare a content',
        \ 'mapping_mode': 'n',
        \ 'requirements': ['path'],
        \ 'options': { 'opener': 'tabedit' },
        \})
endfunction


" Private --------------------------------------------------------------------
function! s:on_compare(candidates, options) abort
  if empty(a:candidates)
    return
  endif
  let options = extend({
        \ 'opener': '',
        \}, a:options)
  for candidate in a:candidates
    let line = get(candidate, 'line', '')
    let col = get(candidate, 'col', '')
    let cached = get(candidate, 'sign', '!!') !~# '^\%(??\|!!\|.\w\)$'
    execute printf(
          \ 'Gina compare %s %s %s %s %s -- %s',
          \ cached ? '--cached' : '',
          \ gina#util#fnameescape(options.opener, '--opener='),
          \ gina#util#fnameescape(get(candidate, 'line'), '--line='),
          \ gina#util#fnameescape(get(candidate, 'col'), '--col='),
          \ gina#util#fnameescape(get(candidate, 'revision', '')),
          \ gina#util#fnameescape(candidate.path),
          \)
  endfor
endfunction
