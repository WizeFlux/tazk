tazk.controller('StageCtrl', ['$scope', '$location', 'Task', 'Stage', 'Comment', function($scope, $location, Task, Stage, Comment) {

  angular.extend($scope, {
    stateDescriptor: {},
    filteringStates: [],
    comments: [],
    newComment: {},
    stage: {}
  });
  
  $scope.stateDescriptorWatcher = function() {  return JSON.stringify($scope.stateDescriptor) }
  $scope.$watch('stateDescriptorWatcher()', function(value) { $scope.stage.tags = value  });

  $scope.initStage = function(rawData){
    if (rawData.tags) $scope.stateDescriptor = JSON.parse(rawData.tags)
    $scope.stage = rawData;
    angular.forEach($scope.stage.tasks, function(task){
      $scope.stage.tasks[$scope.stage.tasks.indexOf(task)] = new Task(task);
    });
  };
  
  $scope.load = function(id)      {    (new Stage({id: id})).$get($scope.initStage)   }
  $scope.getStage = function ()   {    $scope.stage.$get($scope.initStage)            }
  $scope.saveStage = function ()  {    $scope.stage.$save($scope.initStage)            }

  $scope.newTask = function() {
    var newTask = new Task({stage_id: $scope.stage.id})
    $scope.stage.tasks.unshift(newTask);
    $scope.openTask(newTask); newTask.editing(1);
  };
  
  $scope.removeTask = function(task) {
    var cleanUp = function(){ $scope.stage.tasks.splice($scope.stage.tasks.indexOf(task), 1) };
    if (!task.id) { cleanUp() } else { task.$remove(function(){cleanUp()}) };
  };
  
  $scope.tasksFilter = function(task) {
    // if ($scope.openedTask()) {
    //   return $scope.openedTask() == task;
    // } else 
    if (_.compact($scope.filteringStates).length > 0) {
      return ($scope.filteringStates.indexOf(task.state) > -1) || task.open();
    } else { return true }
  };
  
  $scope.openedTask = function() {
    return _.where($scope.stage.tasks, {isOpen: true})[0];
  }
  
  $scope.openTask = function(task) {
    if ($scope.openedTask()) $scope.openedTask().open(0);
    task.open(1);
  };
  
  $scope.log = function(item){console.log(item)};
  $scope.inv = function(item){item = !item};  
}]);
