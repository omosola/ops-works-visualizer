App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

  $scope.loading = true

  Stacks.query((data) -> 

    for stack in data  
      # Bind instances across layers to the associated unique
      # instances for the stack - so they can be toggled on/off all together
      stack.instanceIDMap = {}
      for instance in stack.instances
        stack.instanceIDMap[instance.id] = instance
        
        if !$scope.optionalInstanceProperties
          $scope.instancePropertiesVisibility = {}
          # don't allow hostname, layer_ids, and id to be toggled on and off; requires explicit inclusion in the view
          $scope.optionalInstanceProperties = (property for property in Object.keys(instance) when property not in ["hostname", "layer_ids", "id"])
          $scope.instancePropertiesVisibility[property] = false for property in $scope.optionalInstanceProperties


    $scope.stacks = data

    $scope.loading = false
  )

  # allows all occurrences of an instance (across layers) to be toggled on/off together
  $scope.instanceIsVisible = (instance) ->
    stack = $scope.selectedStack
    stack and stack.instanceIDMap[instance.id].checked

  $scope.propertyIsVisible = (property) -> $scope.instancePropertiesVisibility[property]
]
