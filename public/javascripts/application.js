// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
   $('#user_course_department').change(function() {
      $('#user_course_number').html("<option>Loading...</option>");
      $('#user_course_number').disabled = true;
      $.get('/courses/numbers/'+$('#user_course_department').val(), function(data) {
        $('#user_course_number').html(data);
        $('#user_course_number').disabled = false;
      });
   });
   
   $('#course_department').change(function() {
      $('#course_number').html("<option>Loading...</option>");
      $('#course_number').disabled = true;
      $.get('/courses/numbers/'+$('#course_department').val(), function(data) {
        $('#course_number').html(data);
        $('#course_number').disabled = false;
      });
   });
});