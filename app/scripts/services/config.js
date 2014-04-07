'use strict';

angular.module('app')
  .factory('Config', function () {
    return {
      datasources: [
        {
          'name' : 'MySQL Sample Database',
          'subprotocol' : 'mysql',
          'subname' : 'mysql',
          'username' : 'mysql',
          'password' : 'mysql'
        },
        {
          'name' : 'Northwind Postgres Database',
          'subprotocol' : 'psql',
          'subname' : 'psql',
          'username' : 'postgres',
          'password' : 'postgres'
        }
      ],
      datasource: null,
      baseUri: ''
    };
  });
