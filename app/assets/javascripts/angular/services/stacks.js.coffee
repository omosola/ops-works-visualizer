App.factory 'Stacks', ['$resource', ($resource) ->
	$resource('/api/v1/stacks/:stackId', { stackId: '@id' })
]