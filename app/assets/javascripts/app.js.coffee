window.App = angular.module('VisualizationApp', ['ngResource'])

window.App.directive('detailsBox', -> 
	return {
		restrict: 'AE',
		replace: 'true',
		template: '<div id="details-box">{{detailsBoxMessage}}</div>',
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