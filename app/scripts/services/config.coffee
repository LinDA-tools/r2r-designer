'use strict'

angular.module 'app'
  .factory 'Config', ->
    datasources = [{
        'name' : 'Northwind Postgres Database'
        'subprotocol' : 'postgresql'
        'subname' : 'mydb'
        'username' : 'postgres'
        'password' : ''
      },
      {
        'name' : 'MySQL Sample Database'
        'subprotocol' : 'mysql'
        'subname' : 'mydb'
        'username' : 'mysql'
        'password' : ''
      }
    ]

    {
      datasources: datasources
      datasource: datasources[0]
      baseUri: ''
    }
