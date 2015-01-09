'use strict'

angular.module 'r2rDesignerApp'
  .factory 'Transform', ($http, _, Config) ->

    transformApi = Config.backend + '/api/v1/transform'

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

      publish: (to, datasource, mapping) ->
        if to? and datasource? and mapping?
          api = transformApi + '/publish/' + to
          $http.post api,
            datasource: datasource
            mapping: mapping
    }
