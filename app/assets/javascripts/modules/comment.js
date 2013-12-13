tazk.factory('Comment', function ($resource) {

  var Comment = $resource('/tasks/:taskId/comments/:commentId.json', {
    authenticity_token: aToken,
    taskId: '@task_id',
    commentId: '@id'
  },{ 
    save: {method: 'PUT'},
    create: {method: 'POST'},
    remove: {method: 'DELETE'}
  });

  angular.extend(Comment.prototype, {
  });
  
  return Comment;
});