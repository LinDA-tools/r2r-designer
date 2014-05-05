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
        $scope.rdf.getSubjectsForTemplate($scope.rdb.table, $scope.config.baseUri, $scope.template).then(function (promise) {
          $scope.triples = promise;
        });
      }
    };

    // mapPredicateToColumn : function() {
    //   // var table = 'products';
    //   // var column = 'ProductName';
    //   // var template = 'http://foo/{ProductID}'; 
    //   // var predicate = 'rdfs:label'; 
    //   var table = this.get('controllers.rdb.currentTable');
    //   var base_uri = this.get('controllers.config.base_uri');
    //   var template = base_uri + this.get('controllers.rdf.subjectTemplate');
    //   var predicate = this.get('controllers.rdf.currentPredicate');
    //   var column = this.get('controllers.rdf.currentColumn');
    //   var subjects = []

    //   $.ajax({
    //     url: 'http://localhost:3000/subjects',
    //     type: 'GET',
    //     async: false,
    //     data: 'table=' + table +
    //           '&template=' + escape(template) + 
    //           '&predicate=' + predicate +
    //           '&column=' + column,
    //     success: function(data) {
    //       subjects = $scope.jsedn.toJS($scope.jsedn.parse(data));
    //     }
    //   });
  
    //   old_subjects = this.get('controllers.rdf.subjects');
    //   this.set('controllers.rdf.subjects', old_subjects.concat(subjects));
    // }
  });
