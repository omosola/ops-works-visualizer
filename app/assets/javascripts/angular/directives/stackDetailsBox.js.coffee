window.App.directive('stackDetailsBox', -> 

  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: '/templates/stackdetailsbox.html'
  }
)

window.App.directive('stackSidebar', ->

  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: '/templates/stacksidebar.html'
  }
)