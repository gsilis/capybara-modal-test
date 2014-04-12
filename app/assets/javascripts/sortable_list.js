//
// Implementation of the functions described in sortable.js
//

function setupSortableList() {

    $('.pretty-list > ul').sortable({

        handle: 'span > span',
        stop: onUpdateListOrder
    });
};

$(function() {

    setupSortableList();
});
