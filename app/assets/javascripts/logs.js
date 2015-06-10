$(document).ready(function () {
  $('.filters').each(function(index) {
    $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show();
  });
  $('.filters').on('click', 'li > a.filter-link', function(event) {
    if (!$(this).hasClass('is-active')) {
      event.preventDefault();
      var filters = $(this).closest('.filters');
      filters.find('.is-open').removeClass('is-open').hide();

      $(this).next().toggleClass('is-open').toggle();
      filters.find('.is-active').removeClass('is-active');
      $(this).addClass('is-active');
    } else {
      event.preventDefault();
    }
  });
});
