/*!
 * froala_editor v2.3.4 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms/
 * Copyright 2014-2016 Froala Labs
 */


!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof module&&module.exports?module.exports=function(b,c){return void 0===c&&(c="undefined"!=typeof window?require("jquery"):require("jquery")(b)),a(c),c}:a(jQuery)}(function(a){"use strict";a.extend(a.FE.POPUP_TEMPLATES,{"video.insert":"[_BUTTONS_][_BY_URL_LAYER_][_EMBED_LAYER_]","video.edit":"[_BUTTONS_]","video.size":"[_BUTTONS_][_SIZE_LAYER_]"}),a.extend(a.FE.DEFAULTS,{videoInsertButtons:["videoBack","|","videoByURL","videoEmbed"],videoEditButtons:["videoDisplay","videoAlign","videoSize","videoRemove"],videoResize:!0,videoSizeButtons:["videoBack","|"],videoSplitHTML:!1,videoTextNear:!0,videoDefaultAlign:"center",videoDefaultDisplay:"block",videoMove:!0}),a.FE.VIDEO_PROVIDERS=[{test_regex:/^.*((youtu.be)|(youtube.com))\/((v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))?\??v?=?([^#\&\?]*).*/,url_regex:/(?:https?:\/\/)?(?:www\.)?(?:m\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=|embed\/)?([0-9a-zA-Z_\-]+)(.+)?/g,url_text:"//www.youtube.com/embed/$1",html:'<iframe width="640" height="360" src="{url}?wmode=opaque" frameborder="0" allowfullscreen></iframe>'},{test_regex:/^.*(vimeo\.com\/)((channels\/[A-z]+\/)|(groups\/[A-z]+\/videos\/))?([0-9]+)/,url_regex:/(?:https?:\/\/)?(?:www\.)?(?:vimeo\.com)\/(?:channels\/[A-z]+\/|groups\/[A-z]+\/videos\/)?(.+)/g,url_text:"//player.vimeo.com/video/$1",html:'<iframe width="640" height="360" src="{url}" frameborder="0" allowfullscreen></iframe>'},{test_regex:/^.+(dailymotion.com|dai.ly)\/(video|hub)?\/?([^_]+)[^#]*(#video=([^_&]+))?/,url_regex:/(?:https?:\/\/)?(?:www\.)?(?:dailymotion\.com|dai\.ly)\/(?:video|hub)?\/?(.+)/g,url_text:"//www.dailymotion.com/embed/video/$1",html:'<iframe width="640" height="360" src="{url}" frameborder="0" allowfullscreen></iframe>'},{test_regex:/^.+(screen.yahoo.com)\/[^_&]+/,url_regex:"",url_text:"",html:'<iframe width="640" height="360" src="{url}?format=embed" frameborder="0" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" allowtransparency="true"></iframe>'},{test_regex:/^.+(rutube.ru)\/[^_&]+/,url_regex:/(?:https?:\/\/)?(?:www\.)?(?:rutube\.ru)\/(?:video)?\/?(.+)/g,url_text:"//rutube.ru/play/embed/$1",html:'<iframe width="640" height="360" src="{url}" frameborder="0" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" allowtransparency="true"></iframe>'}],a.FE.VIDEO_EMBED_REGEX=/^\W*((<iframe.*><\/iframe>)|(<embed.*>))\W*$/i,a.FE.PLUGINS.video=function(b){function c(){var a=b.popups.get("video.insert"),c=a.find(".fr-video-by-url-layer input");c.val("").trigger("change");var d=a.find(".fr-video-embed-layer textarea");d.val("").trigger("change")}function d(){var a=b.$tb.find('.fr-command[data-cmd="insertVideo"]'),c=b.popups.get("video.insert");if(c||(c=f()),!c.hasClass("fr-active")){b.popups.refresh("video.insert"),b.popups.setContainer("video.insert",b.$tb);var d=a.offset().left+a.outerWidth()/2,e=a.offset().top+(b.opts.toolbarBottom?10:a.outerHeight()-10);b.popups.show("video.insert",d,e,a.outerHeight())}}function e(){var c=b.popups.get("video.edit");c||(c=y()),b.popups.setContainer("video.edit",a(b.opts.scrollableContainer)),b.popups.refresh("video.edit");var d=R.find("iframe, embed, video"),e=d.offset().left+d.outerWidth()/2,f=d.offset().top+d.outerHeight();b.popups.show("video.edit",e,f,d.outerHeight())}function f(a){if(a)return b.popups.onRefresh("video.insert",c),!0;var d="";b.opts.videoInsertButtons.length>1&&(d='<div class="fr-buttons">'+b.button.buildList(b.opts.videoInsertButtons)+"</div>");var e="";b.opts.videoInsertButtons.indexOf("videoByURL")>=0&&(e='<div class="fr-video-by-url-layer fr-layer fr-active" id="fr-video-by-url-layer-'+b.id+'"><div class="fr-input-line"><input type="text" placeholder="http://" tabIndex="1"></div><div class="fr-action-buttons"><button type="button" class="fr-command fr-submit" data-cmd="videoInsertByURL" tabIndex="2">'+b.language.translate("Insert")+"</button></div></div>");var f="";b.opts.videoInsertButtons.indexOf("videoEmbed")>=0&&(f='<div class="fr-video-embed-layer fr-layer" id="fr-video-embed-layer-'+b.id+'"><div class="fr-input-line"><textarea type="text" placeholder="'+b.language.translate("Embedded Code")+'" tabIndex="1" rows="5"></textarea></div><div class="fr-action-buttons"><button type="button" class="fr-command fr-submit" data-cmd="videoInsertEmbed" tabIndex="2">'+b.language.translate("Insert")+"</button></div></div>");var g={buttons:d,by_url_layer:e,embed_layer:f},h=b.popups.create("video.insert",g);return h}function g(a){var c,d,e=b.popups.get("video.insert");if(!R&&!b.opts.toolbarInline){var f=b.$tb.find('.fr-command[data-cmd="insertVideo"]');c=f.offset().left+f.outerWidth()/2,d=f.offset().top+(b.opts.toolbarBottom?10:f.outerHeight()-10)}b.opts.toolbarInline&&(d=e.offset().top-b.helpers.getPX(e.css("margin-top")),e.hasClass("fr-above")&&(d+=e.outerHeight())),e.find(".fr-layer").removeClass("fr-active"),e.find(".fr-"+a+"-layer").addClass("fr-active"),b.popups.show("video.insert",c,d,0)}function h(a){var c=b.popups.get("video.insert");c.find(".fr-video-by-url-layer").hasClass("fr-active")&&a.addClass("fr-active")}function i(a){var c=b.popups.get("video.insert");c.find(".fr-video-embed-layer").hasClass("fr-active")&&a.addClass("fr-active")}function j(a){b.events.focus(!0),b.selection.restore(),b.html.insert('<span contenteditable="false" draggable="true" class="fr-jiv fr-video fr-dv'+b.opts.videoDefaultDisplay[0]+("center"!=b.opts.videoDefaultAlign?" fr-fv"+b.opts.videoDefaultAlign[0]:"")+'">'+a+"</span>",!1,b.opts.videoSplitHTML),b.popups.hide("video.insert");var c=b.$el.find(".fr-jiv");c.removeClass("fr-jiv"),c.toggleClass("fr-draggable",b.opts.videoMove),b.events.trigger("video.inserted",[c])}function k(c){if("undefined"==typeof c){var d=b.popups.get("video.insert");c=d.find('.fr-video-by-url-layer input[type="text"]').val()||""}var e=null;if(b.helpers.isURL(c))for(var f=0;f<a.FE.VIDEO_PROVIDERS.length;f++){var g=a.FE.VIDEO_PROVIDERS[f];if(g.test_regex.test(c)){e=c.replace(g.url_regex,g.url_text),e=g.html.replace(/\{url\}/,e);break}}e?j(e):b.events.trigger("video.linkError",[c])}function l(c){if("undefined"==typeof c){var d=b.popups.get("video.insert");c=d.find(".fr-video-embed-layer textarea").val()||""}0!==c.length&&a.FE.VIDEO_EMBED_REGEX.test(c)?j(c):b.events.trigger("video.codeError",[c])}function m(c){if(!b.core.sameInstance(Q))return!0;c.preventDefault(),c.stopPropagation();var d=c.pageX||(c.originalEvent.touches?c.originalEvent.touches[0].pageX:null),e=c.pageY||(c.originalEvent.touches?c.originalEvent.touches[0].pageY:null);return d&&e?(b.undo.canDo()||b.undo.saveStep(),P=a(this),P.data("start-x",d),P.data("start-y",e),O.show(),b.popups.hideAll(),void v()):!1}function n(a){if(!b.core.sameInstance(Q))return!0;if(P){a.preventDefault();var c=a.pageX||(a.originalEvent.touches?a.originalEvent.touches[0].pageX:null),d=a.pageY||(a.originalEvent.touches?a.originalEvent.touches[0].pageY:null);if(!c||!d)return!1;var e=P.data("start-x"),f=P.data("start-y");P.data("start-x",c),P.data("start-y",d);var g=c-e,h=d-f,i=R.find("iframe, embed, video"),j=i.width(),k=i.height();(P.hasClass("fr-hnw")||P.hasClass("fr-hsw"))&&(g=0-g),(P.hasClass("fr-hnw")||P.hasClass("fr-hne"))&&(h=0-h),i.css("width",j+g),i.css("height",k+h),i.removeAttr("width"),i.removeAttr("height"),r()}}function o(a){return b.core.sameInstance(Q)?void(P&&R&&(a&&a.stopPropagation(),P=null,O.hide(),r(),e(),b.undo.saveStep())):!0}function p(a){return'<div class="fr-handler fr-h'+a+'"></div>'}function q(){var c;b.shared.$video_resizer?(Q=b.shared.$video_resizer,O=b.shared.$vid_overlay,b.events.on("destroy",function(){Q.removeClass("fr-active").appendTo(a("body"))},!0)):(b.shared.$video_resizer=a('<div class="fr-video-resizer"></div>'),Q=b.shared.$video_resizer,b.events.$on(Q,"mousedown",function(a){a.stopPropagation()},!0),b.opts.videoResize&&(Q.append(p("nw")+p("ne")+p("sw")+p("se")),b.shared.$vid_overlay=a('<div class="fr-video-overlay"></div>'),O=b.shared.$vid_overlay,c=Q.get(0).ownerDocument,a(c).find("body").append(O))),b.events.on("shared.destroy",function(){Q.html("").removeData().remove(),Q=null,b.opts.videoResize&&(O.remove(),O=null)},!0),b.helpers.isMobile()||b.events.$on(a(b.o_win),"resize.video",function(){t(!0)}),b.opts.videoResize&&(c=Q.get(0).ownerDocument,b.events.$on(Q,b._mousedown,".fr-handler",m),b.events.$on(a(c),b._mousemove,n),b.events.$on(a(c.defaultView||c.parentWindow),b._mouseup,o),b.events.$on(O,"mouseleave",o))}function r(){Q||q(),(b.$wp||a(b.opts.scrollableContainer)).append(Q),Q.data("instance",b);var c=R.find("iframe, embed, video");Q.css("top",(b.opts.iframe?c.offset().top-1:c.offset().top-b.$wp.offset().top-1)+b.$wp.scrollTop()).css("left",(b.opts.iframe?c.offset().left-1:c.offset().left-b.$wp.offset().left-1)+b.$wp.scrollLeft()).css("width",c.outerWidth()).css("height",c.height()).addClass("fr-active")}function s(c){if(c&&"touchend"==c.type&&S)return!0;if(c.preventDefault(),c.stopPropagation(),b.edit.isDisabled())return!1;for(var d=0;d<a.FE.INSTANCES.length;d++)a.FE.INSTANCES[d]!=b&&a.FE.INSTANCES[d].events.trigger("video.hideResizer");b.toolbar.disable(),b.helpers.isMobile()&&(b.events.disableBlur(),b.$el.blur(),b.events.enableBlur()),R=a(this),a(this).addClass("fr-active"),b.opts.iframe&&b.size.syncIframe(),r(),e(),b.selection.clear(),b.button.bulkRefresh(),b.events.trigger("image.hideResizer")}function t(a){R&&(w()||a===!0)&&(Q.removeClass("fr-active"),b.toolbar.enable(),R.removeClass("fr-active"),R=null,v())}function u(){b.shared.vid_exit_flag=!0}function v(){b.shared.vid_exit_flag=!1}function w(){return b.shared.vid_exit_flag}function x(){b.events.on("mousedown window.mousedown",u),b.events.on("window.touchmove",v),b.events.on("mouseup window.mouseup",t),b.events.on("commands.mousedown",function(a){a.parents(".fr-toolbar").length>0&&t()}),b.events.on("blur video.hideResizer commands.undo commands.redo element.dropped",function(){t(!0)})}function y(){var a="";b.opts.videoEditButtons.length>=1&&(a+='<div class="fr-buttons">',a+=b.button.buildList(b.opts.videoEditButtons),a+="</div>");var c={buttons:a},d=b.popups.create("video.edit",c);return b.events.$on(b.$wp,"scroll.video-edit",function(){R&&b.popups.isVisible("video.edit")&&e()}),d}function z(){if(R){var a=b.popups.get("video.size"),c=R.find("iframe, embed, video");a.find('input[name="width"]').val(c.get(0).style.width||c.attr("width")).trigger("change"),a.find('input[name="height"]').val(c.get(0).style.height||c.attr("height")).trigger("change")}}function A(){var c=b.popups.get("video.size");c||(c=B()),b.popups.refresh("video.size"),b.popups.setContainer("video.size",a(b.opts.scrollableContainer));var d=R.find("iframe, embed, video"),e=d.offset().left+d.width()/2,f=d.offset().top+d.height();b.popups.show("video.size",e,f,d.height())}function B(a){if(a)return b.popups.onRefresh("video.size",z),!0;var c="";c='<div class="fr-buttons">'+b.button.buildList(b.opts.videoSizeButtons)+"</div>";var d="";d='<div class="fr-video-size-layer fr-layer fr-active" id="fr-video-size-layer-'+b.id+'"><div class="fr-video-group"><div class="fr-input-line"><input type="text" name="width" placeholder="'+b.language.translate("Width")+'" tabIndex="1"></div><div class="fr-input-line"><input type="text" name="height" placeholder="'+b.language.translate("Height")+'" tabIndex="1"></div></div><div class="fr-action-buttons"><button type="button" class="fr-command fr-submit" data-cmd="videoSetSize" tabIndex="2">'+b.language.translate("Update")+"</button></div></div>";var e={buttons:c,size_layer:d},f=b.popups.create("video.size",e);return b.events.$on(b.$wp,"scroll",function(){R&&b.popups.isVisible("video.size")&&A()}),f}function C(a){R.removeClass("fr-fvr fr-fvl"),"left"==a?R.addClass("fr-fvl"):"right"==a&&R.addClass("fr-fvr"),r(),e()}function D(a){return R?void(R.hasClass("fr-fvl")?a.find("> *:first").replaceWith(b.icon.create("align-left")):R.hasClass("fr-fvr")?a.find("> *:first").replaceWith(b.icon.create("align-right")):a.find("> *:first").replaceWith(b.icon.create("align-justify"))):!1}function E(a,b){var c="justify";R.hasClass("fr-fvl")?c="left":R.hasClass("fr-fvr")&&(c="right"),b.find('.fr-command[data-param1="'+c+'"]').addClass("fr-active")}function F(a){R.removeClass("fr-dvi fr-dvb"),"inline"==a?R.addClass("fr-dvi"):"block"==a&&R.addClass("fr-dvb"),r(),e()}function G(a,b){var c="block";R.hasClass("fr-dvi")&&(c="inline"),b.find('.fr-command[data-param1="'+c+'"]').addClass("fr-active")}function H(){if(R&&b.events.trigger("video.beforeRemove",[R])!==!1){var a=R;b.popups.hideAll(),t(!0),b.selection.setBefore(a.get(0))||b.selection.setAfter(a.get(0)),a.remove(),b.selection.restore(),b.html.fillEmptyBlocks(),b.events.trigger("video.removed",[a])}}function I(a){if(!a.hasClass("fr-dvi")&&!a.hasClass("fr-dvb")){var c=a.css("float");a.css("float","none"),"block"==a.css("display")?(a.css("float",c),0===parseInt(a.css("margin-left"),10)&&(a.attr("style")||"").indexOf("margin-right: auto")>=0?a.addClass("fr-fvl"):0===parseInt(a.css("margin-right"),10)&&(a.attr("style")||"").indexOf("margin-left: auto")>=0&&a.addClass("fr-fvr"),a.addClass("fr-dvb")):(a.css("float",c),"left"==a.css("float")?a.addClass("fr-fvl"):"right"==a.css("float")&&a.addClass("fr-fvr"),a.addClass("fr-dvi")),a.css("margin",""),a.css("float",""),a.css("display",""),a.css("z-index",""),a.css("position",""),a.css("overflow",""),a.css("vertical-align","")}b.opts.videoTextNear||a.removeClass("fr-dvi").addClass("fr-dvb")}function J(){b.$el.find("video").filter(function(){return 0===a(this).parents("span.fr-video").length}).wrap('<span class="fr-video" contenteditable="false"></span>'),b.$el.find("embed, iframe").filter(function(){if(b.browser.safari&&this.getAttribute("src")&&this.setAttribute("src",this.src),a(this).parents("span.fr-video").length>0)return!1;for(var c=a(this).attr("src"),d=0;d<a.FE.VIDEO_PROVIDERS.length;d++){var e=a.FE.VIDEO_PROVIDERS[d];if(e.test_regex.test(c))return!0}return!1}).map(function(){return 0===a(this).parents("object").length?this:a(this).parents("object").get(0)}).wrap('<span class="fr-video" contenteditable="false"></span>');for(var c=b.$el.find("span.fr-video"),d=0;d<c.length;d++)I(a(c[d]));c.toggleClass("fr-draggable",b.opts.videoMove)}function K(){x(),b.helpers.isMobile()&&(b.events.$on(b.$el,"touchstart","span.fr-video",function(){S=!1}),b.events.$on(b.$el,"touchmove",function(){S=!0})),b.events.on("html.set",J),J(),b.events.$on(b.$el,"mousedown","span.fr-video",function(a){a.stopPropagation()}),b.events.$on(b.$el,"click touchend","span.fr-video",s),b.events.on("keydown",function(c){var d=c.which;return!R||d!=a.FE.KEYCODE.BACKSPACE&&d!=a.FE.KEYCODE.DELETE?R&&d==a.FE.KEYCODE.ESC?(t(!0),c.preventDefault(),!1):R&&!b.keys.ctrlKey(c)?(c.preventDefault(),!1):void 0:(c.preventDefault(),H(),!1)},!0),b.events.on("keydown",function(){b.$el.find("span.fr-video:empty").remove()}),f(!0),B(!0)}function L(){R?R.trigger("click"):(b.events.disableBlur(),b.selection.restore(),b.events.enableBlur(),b.popups.hide("video.insert"),b.toolbar.showInline())}function M(a,c){if(R){var d=b.popups.get("video.size"),e=R.find("iframe, embed, video");e.css("width",a||d.find('input[name="width"]').val()),e.css("height",c||d.find('input[name="height"]').val()),e.get(0).style.width&&e.removeAttr("width"),e.get(0).style.height&&e.removeAttr("height"),d.find("input").blur(),setTimeout(function(){R.trigger("click")},b.helpers.isAndroid()?50:0)}}function N(){return R}var O,P,Q,R,S;return b.shared.vid_exit_flag=!1,{_init:K,showInsertPopup:d,showLayer:g,refreshByURLButton:h,refreshEmbedButton:i,insertByURL:k,insertEmbed:l,insert:j,align:C,refreshAlign:D,refreshAlignOnShow:E,display:F,refreshDisplayOnShow:G,remove:H,showSizePopup:A,back:L,setSize:M,get:N}},a.FE.RegisterCommand("insertVideo",{title:"Insert Video",undo:!1,focus:!0,refreshAfterCallback:!1,popup:!0,callback:function(){this.popups.isVisible("video.insert")?(this.$el.find(".fr-marker")&&(this.events.disableBlur(),this.selection.restore()),this.popups.hide("video.insert")):this.video.showInsertPopup()},plugin:"video"}),a.FE.DefineIcon("insertVideo",{NAME:"video-camera"}),a.FE.DefineIcon("videoByURL",{NAME:"link"}),a.FE.RegisterCommand("videoByURL",{title:"By URL",undo:!1,focus:!1,callback:function(){this.video.showLayer("video-by-url")},refresh:function(a){this.video.refreshByURLButton(a)}}),a.FE.DefineIcon("videoEmbed",{NAME:"code"}),a.FE.RegisterCommand("videoEmbed",{title:"Embedded Code",undo:!1,focus:!1,callback:function(){this.video.showLayer("video-embed")},refresh:function(a){this.video.refreshEmbedButton(a)}}),a.FE.RegisterCommand("videoInsertByURL",{undo:!0,focus:!0,callback:function(){this.video.insertByURL()}}),a.FE.RegisterCommand("videoInsertEmbed",{undo:!0,focus:!0,callback:function(){this.video.insertEmbed()}}),a.FE.DefineIcon("videoDisplay",{NAME:"star"}),a.FE.RegisterCommand("videoDisplay",{title:"Display",type:"dropdown",options:{inline:"Inline",block:"Break Text"},callback:function(a,b){this.video.display(b)},refresh:function(a){this.opts.videoTextNear||a.addClass("fr-hidden")},refreshOnShow:function(a,b){this.video.refreshDisplayOnShow(a,b)}}),a.FE.DefineIcon("videoAlign",{NAME:"align-center"}),a.FE.RegisterCommand("videoAlign",{type:"dropdown",title:"Align",options:{left:"Align Left",justify:"None",right:"Align Right"},html:function(){var b='<ul class="fr-dropdown-list">',c=a.FE.COMMANDS.videoAlign.options;for(var d in c)c.hasOwnProperty(d)&&(b+='<li><a class="fr-command fr-title" data-cmd="videoAlign" data-param1="'+d+'" title="'+this.language.translate(c[d])+'">'+this.icon.create("align-"+d)+"</a></li>");return b+="</ul>"},callback:function(a,b){this.video.align(b)},refresh:function(a){this.video.refreshAlign(a)},refreshOnShow:function(a,b){this.video.refreshAlignOnShow(a,b)}}),a.FE.DefineIcon("videoRemove",{NAME:"trash"}),a.FE.RegisterCommand("videoRemove",{title:"Remove",callback:function(){this.video.remove()}}),a.FE.DefineIcon("videoSize",{NAME:"arrows-alt"}),a.FE.RegisterCommand("videoSize",{undo:!1,focus:!1,title:"Change Size",callback:function(){this.video.showSizePopup()}}),a.FE.DefineIcon("videoBack",{NAME:"arrow-left"}),a.FE.RegisterCommand("videoBack",{title:"Back",undo:!1,focus:!1,back:!0,callback:function(){this.video.back()},refresh:function(a){var b=this.video.get();b||this.opts.toolbarInline?(a.removeClass("fr-hidden"),a.next(".fr-separator").removeClass("fr-hidden")):(a.addClass("fr-hidden"),a.next(".fr-separator").addClass("fr-hidden"))}}),a.FE.RegisterCommand("videoSetSize",{undo:!0,focus:!1,callback:function(){this.video.setSize()}})});
