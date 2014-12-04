'use strict'

angular.module 'app'
  .factory 'Transform', ($http, _, Config) ->

    transformApi = Config.backend + '/api/v1/transform'

    {
      dump: (mapping) ->
        if mapping?
          $http.post transformApi + '/dump', {
            mapping: mapping
          }
            .then (res) ->
              console.log res
              transformApi + res.data

      publish: (to, mapping) ->
        if to? and mapping?
          api = transformApi + '/publish/' + to
          $http.post api, { mapping: mapping }
    }
