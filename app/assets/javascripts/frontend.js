// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require bootstrap
//= require google_analytics.js

$(function(){ 
  $(window).scroll(function() {

    // height on Scroll
    var scrolltop = $(window).scrollTop();

    // Height of landing init
    var headerheight = $(".landing-init").height();
    
    console.log(scrolltop);
    console.log(headerheight);
    
    if (headerheight == scrolltop) {
      if (scrolltop > 422) {
        $(".topbar").addClass("visible");
      }
      if (scrolltop < 422) {
        $(".topbar").removeClass("visible");
      }
    } else {
      if (scrolltop > headerheight) {
        $(".topbar").addClass("visible");
      }
      if (scrolltop < headerheight) {
        $(".topbar").removeClass("visible");
      }
    }   
    
  });
});

// Scroll

$(".scroll").click(function(event){
   event.preventDefault();
   //calculate destination place
   var dest=0;
   if($(this.hash).offset().top > $(document).height()-$(window).height()){
        dest= $(document).height()-$(window).height();
   }else{
        dest=$(this.hash).offset().top;
   }
   //go to destination
   $('html,body').animate({scrollTop:dest}, 1000,'swing');
});

