'use strict';

angular.module('app')
  .factory('Rdb', function () {
    return {
      host: 'http://localhost:3000/api/v1/db/',

      tables: [],
      data: [],
      table: 'products',
      columns: [],
      columnsMap: []
    };
  });
