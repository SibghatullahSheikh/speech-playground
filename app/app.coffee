'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
])

App.constant 'API_KEY', '50fb0558e4b0e51888dd5435'
App.constant 'DB_NAME', 'todos'


App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->


  $routeProvider

    .when('/todo', {templateUrl: '/partials/todo.html'})
    .when('/aid', {
      templateUrl: '/partials/aid.html'
      controller:'AidCtrl'})

    # Catch all
    .otherwise({redirectTo: '/todo'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(yes)
])
