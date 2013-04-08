// give a star, should be able to move to stars.js?

$(document).ready(function(){
  $("a.give-star-btn").click(function(e){
    e.preventDefault();
    // get the html for the modal
    group_id = $(this).data('group');
    if (group_id != ""){
      $.get('/achievements/new', {'group_id': group_id}, function(html, status){   
        $("body").append(html);
        $('#achievement_new_group_select').modal('toggle');
      });
    } else {
      $.get('/achievements/new', function(html, status){      
        $("body").append(html);
        $('#achievement_new_group_select').modal('toggle');
        // when the select box is changed
          // fire another request to the server to get HTML that
          // will allow you to give a new star to that group
        $("#achievement_new_group_select select").change(function(){
          group_id = $(this).find(":selected").attr("value");
          $.get('/achievements/new?group_id='+group_id, function(html, status){
            $('#achievement_new_group_select').modal('toggle');
            $('#achievement_new_group_select').replaceWith(html);
            $('#achievement_new_group_select').modal('toggle');
          });
        });
      });
    }
    // pop the modal up

    return false;
  });

})

// loading button

function hideLoading() {
    // other code can be placed here 
    $("#loading").hide();
    // other code can be placed here
}

function showLoading() {
    // other code can be placed here 
    $("#loading").show();
    // other code can be placed here
}

function dosomething() {
    showLoading();
    // simulate a task that can take 3 seconds
    // afterwards show hide the loading GIF
    setTimeout("hideLoading()", 5000);
    return false;
}

// $(function(){
//     $('#update-button').click(dosomething());
// });

$(function(){
    $("#update-user").on('click', (function(event){ 
          event.preventDefault();
          // not sure if below is correct
          $(this).submit;
          dosomething();
    }));
});





