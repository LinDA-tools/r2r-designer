'use strict';

angular.module('app')
  .factory('Config', function () {

    var datasources = [
      {
        'name' : 'Northwind Postgres Database',
        'subprotocol' : 'psql',
        'subname' : 'psql',
        'username' : 'postgres',
        'password' : 'postgres'
      },
      {
        'name' : 'MySQL Sample Database',
        'subprotocol' : 'mysql',
        'subname' : 'mysql',
        'username' : 'mysql',
        'password' : 'mysql'
      }
    ];

    return {
      datasources: datasources,
      datasource: datasources[0],
      baseUri: ''
    };
  });
