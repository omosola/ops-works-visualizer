window.App.directive('detailsBox', -> 
	generateTemplate = () ->
		html = "<div ng-bind-html-unsafe='detailsBoxMessage' class='details-box'>"
		html += "{{object}}"
		html += "</div>"

	return {
		restrict: 'AE',
		replace: 'true',
		template: generateTemplate(),
		link: (scope, elem, attrs) ->
			elem.bind('click', (event) ->
				elem.html(scope.detailsBoxMessage)
				elem.css({
					'top': event.pageY,
					'right': event.pageX
				})
			)
	}
)
