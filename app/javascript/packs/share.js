document.addEventListener('DOMContentLoaded', function () {
    const copyLinkButton = document.getElementById('copy-link-button');
    const resultsLinkInput = document.getElementById('results-link');

    copyLinkButton.addEventListener('click', function () {
        resultsLinkInput.select();
        document.execCommand('copy');
    });
});
