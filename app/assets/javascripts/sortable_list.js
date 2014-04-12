//
// Implementation of the functions described in sortable.js
//

function setupSortableList() {

    $('.pretty-list > ul').sortable({

        handle: 'span > span',
        placeholder: 'sortable-placeholder',
        stop: onUpdateListOrder
    });
};

$(function() {

    setupSortableList();
});
