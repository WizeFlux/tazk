tazk.directive('ngCoordinator', function() {
  return {
    restrict: 'E',
    scope: {
      task: '='
    },
    link: function(scope, element, attrs) {
      attrs.$observe('ngModel', function(val) {
        console.log(val);
      });
    }
  }
});