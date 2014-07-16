window.App.directive('detailsBox', -> 
	generateTemplate = () ->
		html = "<div class='details-box'>"
		
		html += "{{object}}"

		## TODO: Need access to object here in order
		# to iterate through the keys
		#for key,value in ""object
		#	html += "<p>" + key + ": " + value + "</p>"

		html += "</div>"

	return {
		restrict: 'AE',
		replace: 'true',
		scope: {
			object: '@' # which of the three do I need? @/=/&
		},
		template: generateTemplate(),
		link: (scope, elem, attrs) ->
			scope.object = attrs.object
			scope.type = attrs.type
	}
)