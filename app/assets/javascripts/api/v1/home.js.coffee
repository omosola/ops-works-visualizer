# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

ready = ->
  $('#image-downloader').click(() ->
      # Remove height:100% for stack-visualization
      # So all the content is visible one the page and can be saved
      # in an image; Only necessary if the content overflows the div
      if overflowing('stack-visualization')
        $('#stack-visualization').css('height', 'auto')

      $('.flashscreen').fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100)

      # Requires a time delay to call onrendered after the div has been set to
      # height auto and not before
      saveDivToPng('#stack-visualization', () ->
        # do this after the image has already been rendered and saved
        # revert to the normal height: 100% scrolling size of stack-visualization
        $('#stack-visualization').css('height', '100%')
      )
  )

  saveDivToPng = (elementId, callback) ->
    html2canvas($(elementId), {
      onrendered: (canvas) ->
        Canvas2Image.saveAsPNG(canvas)
        callback()
    })

  overflowing = (elementId) ->
    element = document.getElementById(elementId)
    
    element && (element.offsetHeight < element.scrollHeight ||
    element.offsetWidth < element.scrollWidth)

$(document).ready(ready)