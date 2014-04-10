//
// Functions to support list sorting
//

/**
 * Initiates a request to save the reordered list items
 * @param {string} endpoint - The URL that can process the request
 * @param  {array} ids      - The list of IDs in correct order
 */
function updateListOrder(endpoint, ids) {

    var params = { pretty_list_item_ids: ids };

    $.ajax(endpoint, {

        data: params,
        dataType: 'script',
        complete: onUpdateListOrderResponse,
        type: 'post'
    });
};

/**
 * Handler for the sort order ajax response
 * Check out {@link https://api.jquery.com/jQuery.ajax}
 * @param  {jqXHR} jqXHR        - An object provided by jQuery
 * @param  {string} textStatus  - The status reported from jQuery
 */
function onUpdateListOrderResponse(jqXHR, textStatus) {

    switch(textStatus) {
        case 'success':
            onUpdateListOrderResponseSuccess(jqXHR);
            break;
        default:
            onUpdateListOrderResponseError(textStatus);
            break;
    }
};

/**
 * Handler for a successful response from the reordering endpoint
 * @param  {jqXHR} jqXHR - The object provided by jQuery to the response handler
 */
function onUpdateListOrderResponseSuccess(jqXHR) {

    // The response should be script
    eval(jqXHR.responseText);
};

/**
 * Handler for an unsuccessful response from the reordering endpoint
 * @param  {string} textStatus - The status of the response returned by the server
 */
function onUpdateListOrderResponseError(textStatus) {

    // Alert the user with a flash message
    var message = 'Could not update sort order because of: ' + textStatus;
    displayFlashMessage(wrapWithFlashMessageHtmlDanger(message));
};

/**
 * Handler for the jquery ui stop event
 * Check out {@link http://api.jqueryui.com/sortable}
 * @param  {event}  event   - The event object supplied by jQuery UI
 * @param  {object} ui      - An object supplied by jQuery UI
 */
function onUpdateListOrder(event, ui) {

    var $parent     = $(ui.item).parent('ul'),
        ids         = getListItemIds($(ui.item).parent('ul')),
        endpoint    = $parent.attr('data-reorderurl');

    updateListOrder(endpoint, ids);
};

/**
 * Fetches all of the IDs of elements within the passed container
 * The item must have its integer ID set as a 'data-id' attribute
 * @param  {jQuery} $container  - jQuery object containing the list item direct parent
 * @return {array}              - The list of IDs in order of appearance
 */
function getListItemIds($container) {

    var ids = [];
    $container.children().each(function(child_index, child_item) {

        var $child_item = $(child_item);
        if ($child_item.attr('data-id')) ids.push($child_item.attr('data-id'));
    });
    return ids;
};
