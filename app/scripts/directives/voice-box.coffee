angular.module('app.directives.voice-box', [])
.directive('voiceBox', ['$parse', '$window', ($parse, $window)->
    restrict: 'E'
    templateUrl: '/partials/directives/voice-box.html'
    scope:
      author:       '='
      ingredients:  '='
      tasks:        '='

    controller: ($scope, $element, $attrs)->
      $scope.finishedText = ''
      $scope.interimText = ''

      $scope.selectedColumn = 'ingredients'

      if not 'webkitSpeechRecognition' in $window
        alert 'Speech recognition is not supported by your browser.'
      else
        recognition                 = new webkitSpeechRecognition
        recognition.continuous      = yes
        recognition.interimResults  = yes

        recognition.onstart =
          -> console.log 'recognition started...'

        recognition.onend = -> $scope.onend()

        $scope.onend = ->
          console.log 'recognition finished'
          $scope.isTalking = no
          $scope.$apply ->
            $scope.isTalking = no
            $scope.interimText = ''
          # $scope.$digest()

        recognition.onerror = (err)->
          console.log err
          throw err
          $scope.isTalking = no

        recognition.onresult = (e)->
          if typeof e.results is 'undefined'
            console.log 'error'
            return
          interimTranscript = ''
          finalTranscript = $scope.finishedText

          for i in [e.resultIndex...e.results.length] by 1
            result = e.results[i]
            if result.isFinal
              finalTranscript = finalTranscript + result[0].transcript
            else
              interimTranscript = interimTranscript + result[0].transcript
  

          if finalTranscript
            applyCommand finalTranscript
            # applyCommand e.results[e.results.length - 1][0].transcript
            # $scope.answers.unshift text: finalTranscript
          # $scope.finishedText = finalTranscript
          $scope.interimText = interimTranscript
          $scope.$apply()

        $scope.start = ->
          _.delay (->
            recognition.lang = 'en-EN'
            recognition.start()
            ), 1000

        $scope.stop = ->
          recognition.stop()

        $scope.toggleRecognition = ->
          $scope.isTalking = not $scope.isTalking
          if $scope.isTalking then $scope.start() else $scope.stop()

        applyCommand = (command)->
          nameRegex = /my name is \w*|I am \w*/i
          nameReplaceRegex = /My name is |I am /i
          command = command.toLowerCase()

          command = command.trim()
          console.log "execute command: " + command

          if command.match nameRegex
            name = command
              .match(nameRegex)[0]
              .replace nameReplaceRegex, ''
            name = name.split('')
            name[0] = name[0].toUpperCase()
            name = name.join ''
            $scope.author.name = name
            # alert "Cześć, #{name}!"

          else if command is 'ingredients'
              $scope.selectedColumn = 'ingredients'
          else if command is 'Thats not mine'or command is 'Thats not mine'
              $window.location.href = '//2013pto.pl'
              # $scope.selectedColumn = 'tasks'
          else if command is 'recipe'
              $scope.selectedColumn = 'tasks'
          else if command is 'stop'or command is 'koniec'
              $scope.stop()
          else if command is 'remove all'or command is 'remove all'
              $scope[$scope.ingredients] = []
              $scope[$scope.tasks] = []
          else if command is 'notify'
            alert 'command!'
          else $scope[$scope.selectedColumn].unshift text: command
          

  ])