/* global escape:true */
'use strict';

angular.module('app')
  .controller('RdfCtrl', function ($scope, $http, Rdb, Config, Jsedn) {

    $scope.icons = [{'value':'Gear','label':'<i class=\'fa fa-gear\'></i> Gear'},{'value':'Globe','label':'<i class=\'fa fa-globe\'></i> Globe'},{'value':'Heart','label':'<i class=\'fa fa-heart\'></i> Heart'},{'value':'Camera','label':'<i class=\'fa fa-camera\'></i> Camera'}];

    $scope.rdb = Rdb;
    $scope.config = Config;
    $scope.jsedn = Jsedn;

    $scope.subjectTemplate = '';
    $scope.objectTemplate = '';
    $scope.type = '';
    $scope.column = '';
    $scope.property = '';
    $scope.triples = [];
    $scope.prefixMap = {};

    $scope.properties = [
      'rdf:type',
      'rdfs:label',
      'rdfs:comment',
      'rdfs:seeAlso'
    ];

    $scope.getProperties = function (val) {
      return $http.get('http://lov.okfn.org/dataset/lov/api/v2/autocomplete/terms', {
        params: {
          q: val,
          type: 'property'
        }
      }).then(function (res) {
        var properties = [];
        angular.forEach(res.data.results, function(item) {
          var prefix = item.prefixedName.slice(0, item.prefixedName.length - item.localName.length - 1);
          if ($scope.prefixMap[prefix] === undefined) {
            $http.get('http://lov.okfn.org/dataset/lov/api/v2/autocomplete/vocabularies', {
              params: {
                q: prefix
              }
            }).then(function (res) {
              $scope.prefixMap[prefix] = res.data.results[0].uri;
            });
          }

          properties.push({
            uri: item.uri,
            localName: item.localName,
            prefix: prefix + ':',
            score: item.score.toPrecision(3)
          });
        });
        return properties;
      });
    };

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
        
        $http.get($scope.rdb.host +
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
