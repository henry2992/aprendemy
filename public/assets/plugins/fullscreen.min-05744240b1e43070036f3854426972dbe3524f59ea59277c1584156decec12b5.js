!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):"object"==typeof module&&module.exports?module.exports=function(t,n){return void 0===n&&(n="undefined"!=typeof window?require("jquery"):require("jquery")(t)),e(n),n}:e(jQuery)}(function(e){"use strict";e.FE.PLUGINS.fullscreen=function(t){function n(){return t.$box.hasClass("fr-fullscreen")}function i(){l=e(t.o_win).scrollTop(),t.$box.toggleClass("fr-fullscreen"),e("body").toggleClass("fr-fullscreen"),d=e('<div style="display: none;"></div>'),t.$box.after(d),t.helpers.isMobile()&&(t.$tb.data("parent",t.$tb.parent()),t.$tb.prependTo(t.$box),t.$tb.data("sticky-dummy")&&t.$tb.after(t.$tb.data("sticky-dummy"))),c=t.opts.height,u=t.opts.heightMax,t.opts.height=t.o_win.innerHeight-(t.opts.toolbarInline?0:t.$tb.outerHeight()),t.opts.heightMax=null,t.size.refresh(),t.opts.toolbarInline&&t.toolbar.showInline();for(var n=t.$box.parent();!n.is("body");)n.data("z-index",n.css("z-index")).css("z-index","9990"),n=n.parent();t.events.trigger("charCounter.update"),t.$win.trigger("scroll")}function o(){t.$box.toggleClass("fr-fullscreen"),e("body").toggleClass("fr-fullscreen"),t.$tb.prependTo(t.$tb.data("parent")),t.$tb.data("sticky-dummy")&&t.$tb.after(t.$tb.data("sticky-dummy")),t.opts.height=c,t.opts.heightMax=u,t.size.refresh(),e(t.o_win).scrollTop(l),t.opts.toolbarInline&&t.toolbar.showInline(),t.events.trigger("charCounter.update"),t.opts.toolbarSticky&&t.opts.toolbarStickyOffset&&(t.opts.toolbarBottom?t.$tb.css("bottom",t.opts.toolbarStickyOffset).data("bottom",t.opts.toolbarStickyOffset):t.$tb.css("top",t.opts.toolbarStickyOffset).data("top",t.opts.toolbarStickyOffset));for(var n=t.$box.parent();!n.is("body");)n.data("z-index")&&(n.css("z-index",""),n.css("z-index")!=n.data("z-index")&&n.css("z-index",n.data("z-index")),n.removeData("z-index")),n=n.parent();t.$win.trigger("scroll")}function a(){n()?o():i(),r(t.$tb.find('.fr-command[data-cmd="fullscreen"]'))}function r(e){var i=n();e.toggleClass("fr-active",i),e.find("> *").replaceWith(i?t.icon.create("fullscreenCompress"):t.icon.create("fullscreen"))}function s(){return!!t.$wp&&(t.events.$on(e(t.o_win),"resize",function(){n()&&(o(),i())}),void t.events.on("toolbar.hide",function(){return(!n()||!t.helpers.isMobile())&&void 0}))}var l,d,c,u;return{_init:s,toggle:a,refresh:r,isActive:n}},e.FE.RegisterCommand("fullscreen",{title:"Fullscreen",undo:!1,focus:!1,forcedRefresh:!0,callback:function(){this.fullscreen.toggle()},refresh:function(e){this.fullscreen.refresh(e)},plugin:"fullscreen"}),e.FE.DefineIcon("fullscreen",{NAME:"expand"}),e.FE.DefineIcon("fullscreenCompress",{NAME:"compress"})});