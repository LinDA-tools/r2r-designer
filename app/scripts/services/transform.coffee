'use strict'

angular.module 'app'
  .factory 'Transform', ($http, _) ->

    host = 'http://localhost:3000'
    transformApi = host + '/api/v1/transform'

    {
      dumpdb: (mapping) ->
        if mapping?
          $http.post transformApi + '/dump-db', {
            mapping: mapping
          }
            .then (res) ->
              transformApi + res.data

      dumpcsv: (mapping) ->
        if mapping?
          $http.post transformApi + '/dump-csv', {
            mapping: mapping
          }
            .then (res) ->
              transformApi + res.data

      publish: (to, mapping) ->
        if to? and mapping?
          api = transformApi + '/publish/' + to
          $http.post api, { mapping: mapping }
    }
