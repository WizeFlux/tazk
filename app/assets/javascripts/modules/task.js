tazk.factory('Task', function ($resource, Comment) {

  var Task = $resource('/tasks/:taskId.json', {
    authenticity_token: aToken,
    taskId: '@id'
  },{ 
    save: {method: 'PUT'},
    create: {method: 'POST'},
    remove: {method: 'DELETE'}
  });
  
  angular.extend(Task.prototype, {
    removeComment: function(comment){
      var proxy = this;
      comment.$remove(function(){
        proxy.comments.splice(proxy.comments.indexOf(comment), 1);
      });
    },
    
    addComment: function(attributes){
      var proxy = this;
      (new Comment(_.extend(attributes, {task_id: this.id}))).$create(function(comment){
        proxy.comments.unshift(comment);
      });
    },
    
    loadComments: function(){
      this.comments = Comment.query({taskId: this.id}, function(){
        _.each(this.comments, function(comment){
          this.comments[this.comments.indexOf(comment)] = new Comment(comment);
        });
      });
    },
    
    editing: function(cmd){
      switch(cmd){
        case 0:  this.isEditing = false; break;
        case 1:  this.isEditing = true; this.open(1); break;
        default: return this.isEditing;
      }
    },
    
    open: function(cmd){
      switch(cmd){
        case 0:  this.isOpen = false; this.editing(0); break;
        case 1:  this.isOpen = true; this.loadComments(); break;
        default: return this.isOpen;
      }
    }
  });
  
  return Task;
});