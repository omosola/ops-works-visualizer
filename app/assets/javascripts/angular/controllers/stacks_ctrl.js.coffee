App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

  $scope.loading = true

  Stacks.query((data) -> 
    $scope.stacks = data
    $scope.loading = false
  )
]
