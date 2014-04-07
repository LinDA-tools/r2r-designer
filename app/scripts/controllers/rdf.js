/* global escape:true */
'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, $http, Rdb, Config, Jsedn) {

    $scope.rdb = Rdb;
    $scope.config = Config;
    $scope.jsedn = Jsedn;

    $scope.host = 'http://localhost:3000/';

    $scope.subjectTemplate = '';
    $scope.objectTemplate = '';
    $scope.type = '';
    $scope.column = '';
    $scope.property = '';
    $scope.triples = [];

    $scope.properties = [
      'rdf:type',
      'rdf:first',
      'rdf:rest',
      'rdf:value',
      'rdf:subject',
      'rdf:predicate',
      'rdf:object',
      'rdfs:subClassOf',
      'rdfs:subPropertyOf',
      'rdfs:domain',
      'rdfs:range',
      'rdfs:label',
      'rdfs:comment',
      'rdfs:member',
      'rdfs:seeAlso',
      'rdfs:isDefinedBy'
    ];

    $scope.types = [
      'rdf:XMLLiteral',
      'rdf:Property',
      'rdf:Statement',
      'rdf:Alt',
      'rdf:Bag',
      'rdf:Seq',
      'rdf:List',
      'rdf:nil',
      'rdfs:Resource',
      'rdfs:Literal',
      'rdfs:Class',
      'rdfs:Datatype',
      'rdfs:Container',
      'rdfs:ContainerMembershipProperty'
    ];

    $scope.submitSubjectTemplate = function (template) {
      if (($scope.rdb.table !== '') && (template !== '')) {
        var triples = [];
        
        $http.get($scope.host +
                  'subjects' +
                  '?table=' + $scope.rdb.table +
                  '&template=' + escape($scope.config.baseUri + template)).success(function(data) {
          var mydata = $scope.jsedn.toJS($scope.jsedn.parse(data));
          for (var i = 0; i < mydata.length; i++) {
            triples.push([mydata[i], 'rdf:type', 'rdfs:resource']);
          }
        });

        $scope.triples = triples;
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
