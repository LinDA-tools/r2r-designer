'use strict'

angular.module 'app'
  .factory 'Transform', ($http, _) ->

    host = 'http://localhost:3000'
    transformApi = host + '/api/v1/transform'

    {
      getDumpUrl: (mapping) ->
        if mapping?
          $http.post transformApi, {
            mapping: mapping
          }
            .then (res) ->
              transformApi + res.data

      getMappingUrl: (mapping) ->
        if mapping?
          $http.post transformApi + '/mapping', {
            mapping: mapping
          }
            .then (res) ->
              transformApi + res.data

      publish: (mapping) ->
        if mapping?
          $http.post transformApi, {
            mapping: mapping
          }
            .then (res) ->
              res.data
    }
