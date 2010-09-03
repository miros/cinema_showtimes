$(function(){

    $('#favourite_cinemas_toggle').click(function () {
        var checkbox = $('#in_favourite_cinemas');

        if (checkbox.attr('checked')) {
            checkbox.removeAttr('checked');
        } else {
            checkbox.attr('checked', 'checked');
        }
    });

    $('#show_end_time_toggle').click(function() {
       $('.show_end_time').toggle(); 
    });

});