(function() {
  'use strict';
  angular.module('app').controller('PublishCtrl', function($scope, $timeout, $window, _, Rdb, Rdf, Sml, Transform) {
    $scope.rdb = Rdb;
    $scope.rdf = Rdf;
    $scope.sml = Sml;
    $scope.transform = Transform;
    $scope.publishing = false;
    $scope.success = false;
    $scope.dump = function() {
      var mapping, w;
      mapping = {
        tables: $scope.rdb.selectedTables(),
        columns: $scope.rdb.selectedColumns(),
        baseUri: $scope.rdf.baseUri,
        subjectTemplate: $scope.rdf.subjectTemplate,
        classes: $scope.rdf.selectedClasses,
        properties: $scope.rdf.selectedProperties,
        literals: $scope.rdf.propertyLiteralSelection,
        literalTypes: $scope.rdf.propertyLiteralTypes
      };
      w = $window.open('');
      $scope.mapping = $scope.sml.toSml(mapping);
      return $scope.transform.getDumpUrl($scope.mapping).then(function(url) {
        return w.location = url;
      });
    };
    $scope.mapping = function() {
      var mapping, w;
      mapping = {
        tables: $scope.rdb.selectedTables(),
        columns: $scope.rdb.selectedColumns(),
        baseUri: $scope.rdf.baseUri,
        subjectTemplate: $scope.rdf.subjectTemplate,
        classes: $scope.rdf.selectedClasses,
        properties: $scope.rdf.selectedProperties,
        literals: $scope.rdf.propertyLiteralSelection,
        literalTypes: $scope.rdf.propertyLiteralTypes
      };
      $scope.mapping = $scope.sml.toSml(mapping);
      w = $window.open('');
      w.document.open();
      w.document.write('<pre>' + $scope.mapping + '</pre>');
      return w.document.close();
    };
    return $scope.publish = function() {
      var mapping;
      $scope.publishing = true;
      mapping = {
        tables: $scope.rdb.selectedTables(),
        columns: $scope.rdb.selectedColumns(),
        baseUri: $scope.rdf.baseUri,
        subjectTemplate: $scope.rdf.subjectTemplate,
        classes: $scope.rdf.selectedClasses,
        properties: $scope.rdf.selectedProperties,
        literals: $scope.rdf.propertyLiteralSelection,
        literalTypes: $scope.rdf.propertyLiteralTypes
      };
      $scope.publishing = false;
      $scope.success = true;
      return $scope.mapping = $scope.sml.toSml(mapping);
    };
  });

}).call(this);

//# sourceMappingURL=publish.js.map
