window.App.directive('stackDetailsBox', -> 

  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: 'stackdetailsboxtemplate.html'
  }
)

window.App.directive('stackSidebar', ->

  return {
    restrict: 'AE',
    replace: 'true',
    templateUrl: 'stacksidebartemplate.html'
  }
)