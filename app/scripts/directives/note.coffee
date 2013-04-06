angular.module('app.directives.note', [])
.directive('note', ['$parse', ($parse)->
    restrict: 'E'
    scope:
      model: '='
      onRemove: '&'
    templateUrl: '/partials/directives/note.html'
    controller: ($scope)->
      $scope.update = ->
        $scope.model.update()
      $scope.remove = ->
        $scope.onRemove($scope.model)
        $scope.model.remove()
  ])