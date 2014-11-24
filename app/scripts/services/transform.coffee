'use strict'

angular.module 'app'
  .factory 'Transform', ($http, _) ->

    host = 'http://localhost:3000'
    transformApi = host + '/api/v1/transform'

    {
      dump: (mapping) ->
        if mapping?
          $http.post transformApi + '/dump', {
            mapping: mapping
          }
            .then (res) ->
              console.log res
              transformApi + res.data

      publish: (mapping) ->
        if mapping?
          $http.post transformApi, {
            mapping: mapping
          }
            .then (res) ->
              res.data
    }
