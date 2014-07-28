App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	$scope.stacks = Stacks.query()

]