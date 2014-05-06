'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, $http, Config, Rdb, Rdf, Lov, R2rs) {

    $scope.rdb = Rdb;
    
    $scope.template = '';
    $scope.column = '';
    $scope.property = '';
    $scope.triples = [];

    $scope.$watch('column', function (value) {
      if (value) {
        R2rs.getSuggestedProperties(value).then(function (promise) {
          $scope.suggestedProperties = promise;
        });
      }
    }, true);

    $scope.types = function () { return Rdf.baseTypes; };

    $scope.properties = function () {
      if ($scope.suggestedProperties) {
        return $scope.suggestedProperties.concat(Rdf.baseProperties);
      } else {
        return [].concat(Rdf.baseProperties);
      }
    };

    $scope.typeaheadLOVClasses = function (value) {
      return Lov.getLOVTerms(value, 'class');
    };

    $scope.typeaheadLOVProperties = function (value) {
      return Lov.getLOVTerms(value, 'property');
    };

    $scope.$watch('column', function (value) {
      if (value) {
        R2rs.getSuggestedProperties(value).then(function (promise) {
          $scope.suggestedProperties = promise;
        });
      }
    }, true);

    $scope.submitTemplate = function () {
      if ((Rdb.table !== '') && ($scope.template !== '')) {
        R2rs.getSubjectsForTemplate(Rdb.table, Config.baseUri, $scope.template).then(function (promise) {
          $scope.triples = promise;
        });
      }
    };
  });
