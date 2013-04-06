'use strict'

### Directives ###

# register the module with Angular
angular.module('app.directives', [
  'app.directives.note'
  'app.directives.voice-box'
  'app.services'
  'app.directives.ui-events'
])

.directive('appVersion', [
  'version'

(version) ->

  (scope, elm, attrs) ->
    elm.text(version)
])
