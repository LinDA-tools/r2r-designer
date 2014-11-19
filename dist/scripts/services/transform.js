(function() {
  'use strict';
  angular.module('app').factory('Transform', function($http, _) {
    var host, transformApi;
    host = 'http://localhost:3000';
    transformApi = host + '/api/v1/transform';
    return {
      getDumpUrl: function(mapping) {
        if (mapping != null) {
          return $http.post(transformApi, {
            mapping: mapping
          }).then(function(res) {
            return transformApi + res.data;
          });
        }
      },
      getMappingUrl: function(mapping) {
        if (mapping != null) {
          return $http.post(transformApi + '/mapping', {
            mapping: mapping
          }).then(function(res) {
            return transformApi + res.data;
          });
        }
      },
      publish: function(mapping) {
        if (mapping != null) {
          return $http.post(transformApi, {
            mapping: mapping
          }).then(function(res) {
            return res.data;
          });
        }
      }
    };
  });

}).call(this);

//# sourceMappingURL=transform.js.map
