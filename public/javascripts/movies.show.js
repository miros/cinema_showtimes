var attach_toggle = function(checkbox, toggle) {

    toggle.click(function () {
        if (checkbox.attr('checked')) {
            checkbox.removeAttr('checked');
        } else {
            checkbox.attr('checked', 'checked');
        }
    });

};



$(function(){

    attach_toggle($('#in_favourite_cinemas'), $('#favourite_cinemas_toggle'));
    attach_toggle($('#in_3d'), $('#in_3d_toggle'));

    $('#show_end_time_toggle').click(function() {
       $('.show_end_time').toggle(); 
    });

});