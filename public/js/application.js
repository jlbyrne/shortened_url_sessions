$(document).ready(function() {
  $('form.create_url').on('submit',function(e){
    e.preventDefault();
    $.ajax({
      url: '/url_maker',
      type: 'post',
      data: $(this).serialize()
    }).done(function(response){
      $('#confirmation').html(response);
    });
  });
});
