window.App.directive('snapshotButton', ->

  return {
    restrict: 'AE',
    replace: 'true',
    template: '<button id="image-downloader"></button>',
    link: (scope, elem, attrs) ->
      elem.bind('click', () ->
        canvasElementSelector = "#" + attrs.canvaselementid
        flashScreenSelector = "#" + attrs.flashscreenid

        oldHeight = $(canvasElementSelector).css('height')

        if (contentIsOveflowing(attrs.canvaselementid))
          $(canvasElementSelector).css('height', 'auto')

        if (flashScreenSelector)
          flashElement(flashScreenSelector, 2)

        callback = () -> $(canvasElementSelector).css('height', oldHeight)
        saveDivToPng(canvasElementSelector, callback)
      )
  }
)

saveDivToPng = (elementId, callback) ->
  html2canvas($(elementId), {
      onrendered: (canvas) ->
        Canvas2Image.saveAsPNG(canvas)
        callback()
  })

contentIsOveflowing = (elementId) ->
  element = document.getElementById(elementId)

  element && (element.offsetHeight < element.scrollHeight || 
    element.offsetWidth < element.scrollWidth)

flashElement = (elementSelector, numTimes) ->
  for number in [0...numTimes]
    $(elementSelector).fadeIn(100).fadeOut(100)