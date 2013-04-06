angular.module('pl.paprikka.parse', [])
.factory('parseResource', ['$resource', ($resource)->
  console.log 'Initialize Parse.com...'
  APP_ID = "JfPaXk51t0URvVDuox61TFICIZyE09Zz0nXchoFT"
  API_KEY = "hwUzPcqeAosNiz6bxMY0eas1F0YFHM4eXpcCv7cH"
  Parse.initialize APP_ID, API_KEY
  ])

.factory('Todo', ['parseResource', (parseResource)->
    Todo = Parse.Object.extend 'Todo'
    Todos = Parse.Collection.extend model : Todo

    query : (cb)->
      todos = new Todos
      todos.fetch success: (result)-> cb todos

    save  : (data, cb)->
      todo = new Todo data
      todo.save()

  ])