#
# app.controllers.aid Module
#
angular.module('app.controllers.aid',[])
.controller('AidCtrl', ['$scope', ($scope)->
  $scope.author =
    name : 'John Doe'
  $scope.tasks = []
  $scope.ingredients = []
])