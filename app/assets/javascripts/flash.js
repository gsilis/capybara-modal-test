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
