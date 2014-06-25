'use strict'

angular.module 'app'
  .factory 'Config', ->
    datasources = [{
        'name' : 'Northwind Postgres Database'
        'subprotocol' : 'psql'
        'subname' : 'psql'
        'username' : 'postgres'
        'password' : 'postgres'
      },
      {
        'name' : 'MySQL Sample Database'
        'subprotocol' : 'mysql'
        'subname' : 'mysql'
        'username' : 'mysql'
        'password' : 'mysql'
      }
    ]

    {
      datasources: datasources
      datasource: datasources[0]
      baseUri: ''
    }
