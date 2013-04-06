angular.module('app.directives.ui-events', [])
.directive('uiFocus', ->
  (scope, element, attrs)->
    element.bind 'focus', ->
      scope.$apply attrs.uiFocus
  )
.directive('uiBlur', ->
  (scope, element, attrs)->
    element.bind 'blur', ->
      scope.$apply attrs.uiBlur
  )

