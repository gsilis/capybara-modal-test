/**
 * Manages flash messages on a page
 * Use this function to ensure that a buildup of old flash messages does not occur
 * @param {string} html_to_insert The HTML containing flash messages
 * @return {null}
 */
function displayFlashMessage(html_to_insert) {

    // If we find any existing alerts on the page, remove them and just
    // insert the new one.
    $('.alert').remove();
    $('h1').after(html_to_insert);
};


/**
 * Wraps the text passed with flash message HTML tags
 * @param  {string} message_type - The type of message to (info|danger)
 * @param  {string} message_text - The text to display
 * @return {string}              - HTML that can be inserted via displayFlashMessage
 */
function wrapWithFlashMessageHtml(message_type, message_text) {

    var classNames = ['alert', 'alert-dismissable', 'alert-' + message_type];

    return '<div class="' + classNames.join(' ') + '">' +
        message_text +
        '</div>';
};

/**
 * Wraps the text passed within a flash message wrapper of type info
 * @param  {string} message_text - The text to wrap
 * @return {string}              - HTML that can be inserted via displayFlashMessage
 */
function wrapWithFlashMessageHtmlInfo(message_text) {

    return wrapWithFlashMessageHtml('info', message_text);
};

/**
 * Wraps the text passed within a flash message wrapper of type danger
 * @param  {string} message_text - The text to wrap
 * @return {string}              - HTML that can be inserted via displayFlashMessage
 */
function wrapWithFlashMessageHtmlDanger(message_text) {

    return wrapWithFlashMessageHtml('danger', message_text);
};
