'use strict'

angular.module 'app'
  .controller 'RdfCtrl', ($scope, $http, Config, Rdb, Rdf, R2rs) ->

    $scope.rdb = Rdb
    
    $scope.template = ''
    $scope.templateColumns = []
    $scope.column = ''
    $scope.property = ''
    $scope.triples = []

    $scope.$watch 'template', (value) ->
      if value?
        $scope.templateColumns = value.match(/{[^}]*}/g) if value?

    $scope.$watch 'templateColumns', (value) ->
      if $scope.rdb.table? and $scope.template? and value?
        R2rs.getSuggestedDBPediaTypes($scope.rdb.table, $scope.template).then (promise) -> $scope.suggestedTypes = promise

    $scope.$watch 'column', (value) ->
      if value?
        R2rs.getSuggestedLOVProperties(value).then (promise) -> $scope.suggestedProperties = promise

    $scope.types = ->
      if $scope.suggestedTypes?
        $scope.suggestedTypes.concat Rdf.baseTypes
      else
        [].concat Rdf.baseTypes

    $scope.properties = ->
      if $scope.suggestedProperties
        $scope.suggestedProperties.concat Rdf.baseProperties
      else
        [].concat Rdf.baseProperties

    $scope.$watch 'column', (value) ->
      if value
        R2rs.getSuggestedLOVProperties(Rdb.table, value).then (promise) ->
          $scope.suggestedProperties = promise

    $scope.submitTemplate = ->
      if (Rdb.table != '') and ($scope.template != '')
        R2rs.getSubjectsForTemplate(Rdb.table, Config.baseUri, $scope.template).then (promise) ->
          $scope.triples = promise
