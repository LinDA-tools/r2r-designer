'use strict'

angular.module 'app'
  .factory 'Config', ->
    {
      datasource: {
          'name' : 'Northwind Postgres Database'
          'subprotocol' : 'postgresql'
          'subname' : 'mydb'
          'username' : 'postgres'
          'password' : ''
        }
    }
