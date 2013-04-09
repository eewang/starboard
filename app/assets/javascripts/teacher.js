// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

// $('#remove').click(function(e){
//   e.preventDefault();
//   $.get('/users/remove_from_group/?user=3&group=2', function(html){
//     console.log(html)
//   })
// });

$.each($('.teacher-dashboard .student'), function () {
  var self = this;
  $(self).find('.remove').click(function (e) {
    e.preventDefault();
    $(self).remove();
    // get request
    var groupId = ("li[data-group-id=1]").first();
    var userId = $("li[data-group-id=1]").first().data("user-id");
    $.get(("/users/remove_from_group/?user=" + userId + "&group=" + groupId), function(html){
      console.log(html)
    });
  });
});