$(function(){

    $('#favourite_cinemas_toggle').click(function () {
        var checkbox = $('#in_favourite_cinemas');

        if (checkbox.attr('checked')) {
            checkbox.removeAttr('checked');
        } else {
            checkbox.attr('checked', 'checked');
        }
    })

});