(function() {

    $(document).ready(function () {
        enableDropdownForLogFilters();
    });

    var enableDropdownForLogFilters = function () {
        $('.filters').on('click', 'li > a.filter-link', function (event) {
            event.preventDefault();
            if (isInactive(this)) {
                showDropdownForLink(this);
            }
        });
    }

    var isInactive = function (element) {
        return !$(element).hasClass('is-active');
    }

    var showDropdownForLink = function (link) {
        var $link = $(link)
        var filters = $link.closest('.filters');
        // closes currently open tab
        filters.find('.is-open').removeClass('is-open').hide();
        //find the content for the dropdown for this link and show it
        $link.next().toggleClass('is-open').toggle();
        //finds currently active filtered link and removes it
        filters.find('.is-active').removeClass('is-active');
        // makes link that was clicked active
        $link.addClass('is-active');
    }
}());
