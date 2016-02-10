$(document).on('ready page:load', function(){

  $(".simulator-ajax-submittable").on('click', function(e){
    var question_form = $(this).data('form');
    $("."+question_form).submit();
  })
})
