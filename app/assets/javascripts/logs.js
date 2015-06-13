$(document).ready(function () {
  enableDropdownForLogFilters();
});

var enableDropdownForLogFilters = function() { 
  $('.filters').each(function(index) {
    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
  });
  $('.filters').on('click', 'li > a.filter-link', function(event) {
    event.preventDefault();
    if (isInactive(this)) {
      showDropdownForLink(this);
    }
  });
}

var isInactive = function(element) {
  return !$(element).hasClass('is-active');
}

var showDropdownForLink = function(link) {
  var filters = $(link).closest('.filters');
  filters.find('.is-open').removeClass('is-open').hide();

  $(link).next().toggleClass('is-open').toggle();
  filters.find('.is-active').removeClass('is-active');
  $(link).addClass('is-active');
}