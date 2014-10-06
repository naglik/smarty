" Vim syntax file
" Language:	Smarty Templates
" Maintainer:	Manfred Stienstra manfred.stienstra@dwerg.net
" Last Change:  Fri Apr 12 10:33:51 CEST 2002 
" Filenames:    *.tpl
" URL:		http://www.dwerg.net/download/vim/smarty.vim

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'smarty'
endif

syn case ignore

runtime! syntax/html.vim
"syn cluster htmlPreproc add=smartyUnZone

syn keyword smartyTagName block extends capture config_load include include_php
syn keyword smartyTagName insert if elseif else ldelim rdelim literal
syn keyword smartyTagName php section sectionelse foreach foreachelse
syn keyword smartyTagName strip cycle assign counter debug
syn keyword smartyTagName eval fetch html_checkboxes html_image
syn keyword smartyTagName html_options html_radios html_select_date
syn keyword smartyTagName html_select_time html_table mailto
syn keyword smartyTagName math popup popup_init textformat

" Smarty3 Smarty-eigene Funktionen
syn keyword smartyTagName assign_debug_info
" Smarty3 dF-Funktionen
syn keyword smartyTagName captureblock csslit jslit kvddescription kvddisplay kvdkey kvdvalue messagebox scsslit tabpanel tab wrapblock icon res rpimg rpmanaged translate antiphishing blank_img button getRandomPassword img input js_tpl link meter modernizr mwst scssfile select
" Smarty2 alte Funktionen
syn keyword smartyTagName agblink ajax_innerpopup ajax_popup a css dfassign dffaq df_table dg_bestlink dg_corners dg_faq dgoption_box_km dgoption_box dg_table fancy_pager fancy_table fancy_tr form genbestlink hover_box js legenditem legend legendpicitem link li list messagebox meta_input option_box scss smarty sup tabdelim table_field table_rows tabpanel tab tabulator2 tabulator add_hover_divs agbbox_domain agbbox antiphishing array_size autoimgbutton2 autoimgbutton_old autoimgbutton autoimg autosprite captcha cmslink css_file dateselector dfcaptcha domsplit etracker extract_components forumlink fussnote get_address getCurrentPos getRandomPassword hashassign imgbutton inputfield js_file js_include js_ready js_tpl kad_history mindestlaufzeit modernizr mwst newlegend newtab preload progressbar recaptcha request2hidden request scriptbuilder set19 styledbutton styledsubmit telefon vardump

syn keyword smartyInFunc ne eq == != !== > < >= <= === ! %

syn match smartyProperty contained "[a-zA-Z0-9_]\+="

syn match smartyConstant "\$smarty"

syn match smartyDollarSign      contained "\$"
syn match smartyMaybeDollarSign contained "\([^\\]\|\\\\\)\@<=\$"

syn match smartyVariable        contained "\$\h\w*"
syn match smartyVariable        contained "\(\$\h\w*\(\.\|\->\|\[.*\]\(\.\|\->\)\)\)\w*"
syn match smartyMaybeVariable   contained "\(\(^\|[^\\]\|\\\\\)\$\)\h\w*"

syn match smartyEscapedVariable contained "\\$\h\w*"

syn region smartyInBracket    matchgroup=Constant start=+\[+ end=+\]+ contains=smartyVariable, smartyZone contained
syn region smartyStringDouble matchgroup=Constant start=+"+  end=+"+ skip=+\\"+ contains=smartyMaybeVariable, smartyMaybeDollarSign, smartyZone contained keepend
syn region smartyStringSingle matchgroup=Constant start=+'+  end=+'+ skip=+\\'+ contains=smartyZone contained keepend

syn match smartyGlue "\.\|\->"


syn region smartyModifier  matchgroup=Statement start=+|+   end=+\ze:\|\ze|\|\ze}+
syn region smartyParameter matchgroup=Statement start=+:+   end=+\s\|\ze:\|\ze|\|}\@=+ contains=smartyZone, smartyVariable, smartyDollarSign, smartyGlue, smartyInBracket, smartyStringDouble, smartyStringSingle
syn region smartyZone      matchgroup=Statement start="{"   end="}"        contains=smartyParameter, smartyProperty, smartyGlue, smartyModifier, smartyDollarSign, smartyInBracket, smartyStringDouble, smartyStringSingle, smartyVariable, smartyString, smartyBlock, smartyTagName, smartyConstant, smartyInFunc
syn region smartyComment   matchgroup=Comment   start="{\*" end="\*}"

syn region htmlString contained start=+"+ end=+"+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc,smartyZone
syn region htmlString contained start=+'+ end=+'+ contains=htmlSpecialChar,javaScriptExpression,@htmlPreproc,smartyZone
"syn region htmlLink             start="<a\>\_[^>]*\<href\>" end="</a>"me=e-4 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc,smartyZone

unlet b:current_syntax
syn include @htmlJQuery syntax/jquery.vim
syn region  javaScript start=+{js[^}]*}+ keepend end=+{/js}+ contains=@htmlJQuery
syn region  javaScript start=+{block[^}]*\(domready\|js-inline\)[^}]*}+ keepend end=+{/block}+ contains=@htmlJQuery

syn include @htmlCss syntax/css.vim
unlet b:current_syntax
syn region cssStyle start=+{css[^}]*}+ keepend end=+{/css}+ contains=@htmlCss

syn include @htmlScss syntax/scss.vim
unlet b:current_syntax
syn region cssStyle start=+{scss[^}]*}+ keepend end=+{/scss}+ contains=@htmlScss

if version >= 508 || !exists("did_smarty_syn_inits")
  if version < 508
    let did_smarty_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink smartyTagName         Function
  HiLink smartyProperty        Type
  HiLink smartyComment         Comment
  HiLink smartyInFunc          Function
  HiLink smartyBlock           Constant
  HiLink smartyGlue            Statement
  HiLink smartyVariable        Identifier
  HiLink smartyDollarSign      Statement
  HiLink smartyMaybeVariable   Identifier
  HiLink smartyMaybeDollarSign Statement
  HiLink smartyStringSingle    smartyStringDouble
  HiLink smartyStringDouble    Special
  HiLink smartyInBracket       PreProc
  HiLink smartyInBacktick      Statement
  HiLink smartyModifier        Special
"  HiLink cssStyle              Function
"  HiLink javaScript            Function
  delcommand HiLink
endif

let b:current_syntax = "smarty"

if main_syntax == 'smarty'
  unlet main_syntax
endif

" vim: ts=8
