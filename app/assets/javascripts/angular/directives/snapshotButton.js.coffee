window.App.directive('snapshotButton', ->

  return {
    restrict: 'A',
    replace: 'true',
    template: '<a id="image-downloader-icon">'+
              '</a>',
    scope: {
      stackname: '=stackname'
    },
    link: (scope, elem, attrs) ->
      elem.bind('mouseover', () ->
        # updates the download link with the png data for this stack view
        # ensures that the correct view is downloaded when the snapshot button is clicked
        if scope.stackname
          updateDownloadLink(attrs.canvaselementid, scope.stackname)        
      )

      elem.bind('click', (event) ->
        downloadDivAsPng(attrs.flashscreenid)
      )
  }
)

downloadDivAsPng = (flashscreenid) ->
  flashScreenSelector = "#" + flashscreenid
  if (flashScreenSelector)
    flashElement(flashScreenSelector, 2)


updateDownloadLink = (canvaselementid, stackName) ->
  canvasElementSelector = "#" + canvaselementid
  if (contentIsOveflowing(canvaselementid))
    $(canvasElementSelector).css('height', 'auto')

  callback = () -> $(canvasElementSelector).css('height', '100%') 
  
  html2canvas($(canvasElementSelector), {
      onrendered: (canvas) ->
        filename = buildPngFilename(stackName)
        Canvas2Image.saveAsPNG(canvas, $('#image-downloader-icon'), filename)
        callback()
  })

# This implementation is a bit specific to Babbel OpsWorks stack naming conventions
buildPngFilename = (stackName) ->
  filename = stackName.toLowerCase()
  filename = filename.replace(':', '')
  filename = filename.replace(' ', '-')
  filename += '-' + convertUnixToLocalTimeString(Date.now())
  filename += '.png'

convertUnixToLocalTimeString = (unixTimestamp) ->
  date = new Date(unixTimestamp)
  year = date.getFullYear()
  month = ('0' + (date.getMonth() + 1)).slice(-2)
  day = ('0' + date.getDate()).slice(-2)
  hour = date.getHours()
  min = ('0' + date.getMinutes()).slice(-2)
  year + month + day + hour + min


contentIsOveflowing = (elementId) ->
  element = document.getElementById(elementId)

  element && (element.offsetHeight < element.scrollHeight || 
    element.offsetWidth < element.scrollWidth)

flashElement = (elementSelector, numTimes) ->
  for number in [0...numTimes]
    $(elementSelector).fadeIn(100).fadeOut(100)