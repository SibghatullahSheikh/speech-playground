angular.module('app.services.data', ['mongolabResource'])
.factory('data', [->
  APP_ID = 'paprikka.pl.storage'
  get : ->
    storeData = localStorage.getItem(APP_ID)
    if storeData isnt 'undefined' and storeData
      JSON.parse storeData
    else
      []
  save: (todos)-> localStorage.setItem APP_ID, JSON.stringify todos
  ])
.factory('Todo', ($mongolabResource)-> new $mongolabResource 'Todo')