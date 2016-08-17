!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):"object"==typeof module&&module.exports?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n),n}:e(jQuery)}(function(e){"use strict";e.extend(e.FE.DEFAULTS,{codeMirror:!0,codeMirrorOptions:{lineNumbers:!0,tabMode:"indent",indentWithTabs:!0,lineWrapping:!0,mode:"text/html",tabSize:2},codeBeautifierOptions:{end_with_newline:!0,indent_inner_html:!0,extra_liners:["p","h1","h2","h3","h4","h5","h6","blockquote","pre","ul","ol","table","dl"],brace_style:"expand",indent_char:"\t",indent_size:1,wrap_line_length:0}}),e.FE.PLUGINS.codeView=function(t){function n(){return t.$box.hasClass("fr-code-view")}function i(){return u?u.getValue():c.val()}function o(e){var n=i();t.html.set(n),t.$el.blur(),t.$tb.find(" > .fr-command").not(e).removeClass("fr-disabled"),e.removeClass("fr-active"),t.events.focus(!0),t.placeholder.refresh(),t.undo.saveStep()}function a(n){c||(l(),!u&&t.opts.codeMirror&&"undefined"!=typeof CodeMirror?u=CodeMirror.fromTextArea(c.get(0),t.opts.codeMirrorOptions):t.events.$on(c,"keydown keyup change input",function(){if(t.opts.height)this.rows=null;else if(this.rows||(this.rows=1),0===this.value.length)this.rows=1;else{for(this.style.height="auto";this.rows>1&&this.scrollHeight<=this.offsetHeight;)this.rows-=1;for(;this.scrollHeight>this.offsetHeight&&(!t.opts.heightMax||this.offsetHeight<t.opts.heightMax);)this.rows+=1}})),t.undo.saveStep(),t.html.cleanEmptyTags(),t.html.cleanWhiteTags(!0),t.core.hasFocus()&&(t.core.isEmpty()||(t.selection.save(),t.$el.find('.fr-marker[data-type="true"]:first').replaceWith('<span class="fr-tmp fr-sm">F</span>'),t.$el.find('.fr-marker[data-type="false"]:last').replaceWith('<span class="fr-tmp fr-em">F</span>')));var i=t.html.get(!1,!0);t.$el.find("span.fr-tmp").remove(),t.core.hasFocus()&&t.$el.blur(),i=i.replace(/<span class="fr-tmp fr-sm">F<\/span>/,"FROALA-SM"),i=i.replace(/<span class="fr-tmp fr-em">F<\/span>/,"FROALA-EM"),t.codeBeautifier&&(i=t.codeBeautifier.run(i,t.opts.codeBeautifierOptions));var o,a;if(u){o=i.indexOf("FROALA-SM"),a=i.indexOf("FROALA-EM"),o>a?o=a:a-=9,i=i.replace(/FROALA-SM/g,"").replace(/FROALA-EM/g,"");var r=i.substring(0,o).length-i.substring(0,o).replace(/\n/g,"").length,s=i.substring(0,a).length-i.substring(0,a).replace(/\n/g,"").length;o=i.substring(0,o).length-i.substring(0,i.substring(0,o).lastIndexOf("\n")+1).length,a=i.substring(0,a).length-i.substring(0,i.substring(0,a).lastIndexOf("\n")+1).length,u.setSize(null,t.opts.height?t.opts.height:"auto"),t.opts.heightMin&&t.$box.find(".CodeMirror-scroll").css("min-height",t.opts.heightMin),u.setValue(i),u.focus(),u.setSelection({line:r,ch:o},{line:s,ch:a}),u.refresh(),u.clearHistory()}else{o=i.indexOf("FROALA-SM"),a=i.indexOf("FROALA-EM")-9,t.opts.heightMin&&c.css("min-height",t.opts.heightMin),t.opts.height&&c.css("height",t.opts.height),t.opts.heightMax&&c.css("max-height",t.opts.height||t.opts.heightMax),c.val(i.replace(/FROALA-SM/g,"").replace(/FROALA-EM/g,"")).trigger("change");var d=e(t.o_doc).scrollTop();c.focus(),c.get(0).setSelectionRange(o,a),e(t.o_doc).scrollTop(d)}t.$tb.find(" > .fr-command").not(n).addClass("fr-disabled"),n.addClass("fr-active"),!t.helpers.isMobile()&&t.opts.toolbarInline&&t.toolbar.hide()}function r(e){"undefined"==typeof e&&(e=!n());var i=t.$tb.find('.fr-command[data-cmd="html"]');e?(t.popups.hideAll(),t.$box.toggleClass("fr-code-view",!0),a(i)):(t.$box.toggleClass("fr-code-view",!1),o(i))}function s(){n()&&r(t.$tb.find('button[data-cmd="html"]')),u&&u.toTextArea(),c.val("").removeData().remove(),c=null,h&&(h.remove(),h=null)}function l(){c=e('<textarea class="fr-code" tabindex="-1">'),t.$wp.append(c),c.attr("dir",t.opts.direction),t.$box.hasClass("fr-basic")||(h=e('<a data-cmd="html" title="Code View" class="fr-command fr-btn html-switch'+(t.helpers.isMobile()?"":" fr-desktop")+'" role="button" tabindex="-1"><i class="fa fa-code"></i></button>'),t.$box.append(h),t.events.bindClick(t.$box,"a.html-switch",function(){r(!1)}));var o=function(){return!n()};t.events.on("buttons.refresh",o),t.events.on("copy",o,!0),t.events.on("cut",o,!0),t.events.on("paste",o,!0),t.events.on("destroy",s,!0),t.events.on("html.set",function(){n()&&r(!0)}),t.events.on("form.submit",function(){n()&&(t.html.set(i()),t.events.trigger("contentChanged",[],!0))},!0)}function d(){return!!t.$wp&&void 0}var c,u,h;return{_init:d,toggle:r,isActive:n,get:i}},e.FE.RegisterCommand("html",{title:"Code View",undo:!1,focus:!1,forcedRefresh:!0,callback:function(){this.codeView.toggle()},plugin:"codeView"}),e.FE.DefineIcon("html",{NAME:"code"})});