// /* global escape:true */
'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, $http, Config, Rdb, Rdf, Jsedn) {

    $scope.config = Config;
    $scope.rdb = Rdb;
    $scope.rdf = Rdf;
    $scope.jsedn = Jsedn;

    $scope.subjectTemplate = '';
    $scope.objectTemplate = '';
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

    // $scope.submitSubjectTemplate = function (template) {
    //   if (($scope.rdb.table !== '') && (template !== '')) {
    //     var triples = [];
    //     
    //     $http.get($scope.rdb.host +
    //               'subjects' +
    //               '?table=' + $scope.rdb.table +
    //               '&template=' + escape($scope.config.baseUri + template)).success(function(data) {
    //       var mydata = $scope.jsedn.toJS($scope.jsedn.parse(data));
    //       for (var i = 0; i < mydata.length; i++) {
    //         triples.push([mydata[i], 'rdf:type', 'rdfs:resource']);
    //       }
    //     });
    //
    //     $scope.rdf.triples = triples;
    //   }
    // };

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
