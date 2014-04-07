'use strict';

angular.module('app')
  .factory('Rdb', function () {
    return {
      tables: [],
      data: [],
      table: '',
      columns: [],
      columnsMap: []
    };
  });
