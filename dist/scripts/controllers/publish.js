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
      $scope.currentMapping = $scope.sml.toSml(currentMapping);
      return $scope.transform.getDumpUrl($scope.currentMapping).then(function(url) {
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
      $scope.currentMapping = $scope.sml.toSml(currentMapping);
      w = $window.open('');
      w.document.open();
      w.document.write('<pre>' + $scope.currentMapping + '</pre>');
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
      return $scope.currentMapping = $scope.sml.toSml(currentMapping);
    };
  });

}).call(this);

//# sourceMappingURL=publish.js.map
