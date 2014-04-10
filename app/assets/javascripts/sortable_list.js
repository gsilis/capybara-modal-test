//
// Implementation of the functions described in sortable.js
//

$(function() {

    $('.pretty-list > ul').sortable({

        stop: onUpdateListOrder
    });
});
