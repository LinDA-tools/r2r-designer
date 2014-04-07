'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, Rdb) {

    $scope.rdb = Rdb;

    $scope.subjectTemplate = '';
    $scope.objectTemplate = '';
    $scope.type = '';
    $scope.column = '';
    $scope.property = '';
    $scope.subjects = [];
    
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

  });
