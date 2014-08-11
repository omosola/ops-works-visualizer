App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

  $scope.loading = true

  Stacks.query((data) -> 

    # make an indexable map for the instances
    # this is so we can easily associate the layer instances with the
    # unique set of instances that are included in the stack
    # there's no current binding between these two

    ## TODO: Think of a cleaner solution
    for stack in data
      stack.instanceIDMap = {}
      for instance in stack.instances
        stack.instanceIDMap[instance.id] = instance
        # pull an array of the properties of the instance objects
        # - pulled from the first instance of the stack
        # in its own variable just for clarity
        if !$scope.instancePropertiesVisibility
          $scope.instancePropertiesVisibility = {}
          for property in Object.keys(instance)
            if property == "hostname"
              $scope.instancePropertiesVisibility[property] = true
            else if property == "layer_ids"
              delete $scope.instancePropertiesVisibility[property]
            else
              $scope.instancePropertiesVisibility[property] = false
    $scope.instanceProperties = Object.keys($scope.instancePropertiesVisibility)

    $scope.stacks = data

    $scope.loading = false
  )

  $scope.instanceIsVisible = (stack, instance) ->
    stack.instanceIDMap[instance.id].checked 
]
