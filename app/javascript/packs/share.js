document.addEventListener('DOMContentLoaded', function () {
    const customCopyLinkButton = document.getElementById('copy-link-button');
    const resultsLinkInput = document.getElementById('results-link');

    customCopyLinkButton.addEventListener('click', function () {
        resultsLinkInput.select();
        document.execCommand('copy');
    });
});
