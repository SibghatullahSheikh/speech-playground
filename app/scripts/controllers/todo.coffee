angular.module('app.controllers.todo', [])
.controller('TodoCtrl', [
  '$scope'
  '$filter'
  '$resource'
  'data'
  'Todo'
  ($scope, $filter, $resource, data, Todo)->
    $scope.newTodo =
      title: ''

    $scope.addTodo = ->
      o =
        title : $scope.newTodo.title
        created: (new Date()).getTime()
      
      Todo.save o, (data)-> $scope.todos.unshift data
      $scope.newTodo.title = ''

    $scope.removeTodo = (todo)->
      todo.remove()
      $scope.todos.splice $scope.todos.indexOf(todo), 1

    $scope.todosDone = ->
      $filter('todosDone')($scope.todos).length

    $scope.todos = Todo.query()
  ])
