$(document).ready ->
  $('#flickr-block-link').click (event) ->
    event.preventDefault()
    $('#flickr-block').fadeToggle()

  $('#flickr-search-link').click (event) ->
    event.preventDefault()
    $.ajax '/flickr_search',
      type: 'POST',
      data: { flickr_search: $('#flickr-search-input').val() }
  
$(document).ajaxComplete ->
  $('.flickr-image-link').click ->
    imageUrl = $(this).children('img').attr("src")
    $('#card-image').val(imageUrl)
    $('#flickr-block').fadeToggle()
