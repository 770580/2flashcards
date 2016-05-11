$(document).ready ->
  $('#flickr-link').click (event) ->
    event.preventDefault()
    $('#flickr-images').fadeToggle()

$(document).ready ->
  $('#flickrModalBox').on 'show.bs.modal', ->
    $('.flickr-image-link').click ->
      imageUrl = $(this).children('img').attr("src")
      $('#card-image').val(imageUrl)
      $('#flickrModalBox').modal('hide')