// give a star
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
    return false;
  });
})

// refill star bank
$(document).ready(function(){
  console.log("jquery awake");
  $("a.refill-star-btn").click(function(e){
    console.log("click works");
    e.preventDefault();


      $.get('/refill_star_bank', function(html, status){      
        $("body").append(html);

        console.log($('#refill_star_bank') + "id refill star bank found");
        $('#refill_star_bank').modal('toggle');
        // when the select box is changed
          // fire another request to the server to get HTML that
          // will allow you to give a new star to that group
        $("#refill_star_bank select").change(function(){
          group_id = $(this).find(":selected").attr("value");
          console.log("group_id is " + group_id);
          // $.get('/achievements/new?group_id='+group_id, function(html, status){
          //   $('#achievement_new_group_select').modal('toggle');
          //   $('#achievement_new_group_select').replaceWith(html);
          //   $('#achievement_new_group_select').modal('toggle');
          // });
        });
      });
    
    return false;
  });
})