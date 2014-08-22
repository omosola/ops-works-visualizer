App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

  $scope.loading = true

  # on initial page load, call GET /stacks
  $scope.stacks = Stacks.query(() -> 
    $scope.loading = false
  )

  # Method: instanceIsVisible
  # -----------------------------
  # Purpose:          Allows all occurrences of an instance (across layers) to be toggled on/off together
  # Implementation:   Checks in the instanceIDMap to see if this particular instance's source instance
  #                   has been toggled on or off for visibility
  # Parameters:       instance - Instance object
  # Return:           @boolean
  $scope.instanceIsVisible = (instance) ->
    stack = $scope.selectedStack
    stack and stack.instanceIDMap[instance.id].checked


  # Method: propertyIsVisible
  # -----------------------------
  # Purpose:          Determines the visibility of a property in the instance display boxes
  # Parameters:       property - string
  # Return:           @boolean
  $scope.propertyIsVisible = (property) ->
    $scope.instancePropertiesVisibility[property]

  # Method: loadStackInfo
  # -----------------------------
  # Purpose:          Loads the details for the selected stack (details include ELBs, Layers, and Instances)
  # Implementation:   Used for lazy loading. On page load, only basic stack information is pulled, then
  #                   individual stack details are pulled when the stack is selected from the dropdown
  #                   Calls API to get stack details, then sets selectedStack to the returned data
  # Parameters:       selectedStackId - int
  # Return:           @void
  # lazy load stack info when stack is explicitly selected by the user
  $scope.loadStackInfo = (selectedStackId) ->
    $scope.loading = true
    Stacks.get({ stackId: selectedStackId }, (data) ->

      # Bind instances across layers to the associated unique instances for
      # the stack - so they can be toggled on/off all together
      data.instanceIDMap = {}
      for instance in data.instances
        data.instanceIDMap[instance.id] = instance

        if !$scope.optionalInstanceProperties
          $scope.instancePropertiesVisibility = {}
          # don't allow hostname, layer_ids, and id to be toggled on/off;
          # requires explicit inclusion in the view
          $scope.optionalInstanceProperties = (property for property in Object.keys(instance) when property not in ["hostname", "layer_ids", "id"])
          $scope.instancePropertiesVisibility[property] = false for property in $scope.optionalInstanceProperties

      $scope.selectedStack = data
      $scope.loading = false
    )
]
