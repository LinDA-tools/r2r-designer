'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, $http, Config, Rdb, Rdf, Jsedn) {

    $scope.config = Config;
    $scope.rdb = Rdb;
    $scope.rdf = Rdf;
    $scope.jsedn = Jsedn;

    $scope.template = '';
    $scope.column = '';
    $scope.property = '';
    $scope.triples = [];

    $scope.$watch('column', function (value) {
      if (value) {
        $scope.rdf.getSuggestedProperties(value).then(function (promise) {
          $scope.suggestedProperties = promise;
        });
      }
    }, true);

    $scope.types = function () { return $scope.rdf.baseTypes; };

    $scope.properties = function () {
      if ($scope.suggestedProperties) {
        return $scope.suggestedProperties.concat($scope.rdf.baseProperties);
      } else {
        return [].concat($scope.rdf.baseProperties);
      }
    };

    $scope.typeaheadLOVClasses = function (value) {
      return $scope.rdf.getLOVEntities(value, 'class');
    };

    $scope.typeaheadLOVProperties = function (value) {
      return $scope.rdf.getLOVEntities(value, 'property');
    };

    $scope.$watch('column', function (value) {
      if (value) {
        $scope.rdf.getSuggestedProperties(value).then(function (promise) {
          $scope.suggestedProperties = promise;
        });
      }
    }, true);

    $scope.submitTemplate = function () {
      if (($scope.rdb.table !== '') && ($scope.template !== '')) {
        $scope.rdb.getSubjectsForTemplate($scope.rdb.table, $scope.config.baseUri, $scope.template).then(function (promise) {
          $scope.triples = promise;
        });
      }
    };
  });
