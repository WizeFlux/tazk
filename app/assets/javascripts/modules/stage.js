tazk.factory('Stage', function ($resource) {

  var Stage = $resource('/stages/:stageId.json', {
    authenticity_token: aToken,
    stageId: '@id'
  },{ 
    save: {method: 'PUT'},
    create: {method: 'POST'},
    remove: {method: 'DELETE'}
  });

  angular.extend(Stage.prototype, {
  });
  
  return Stage;
});