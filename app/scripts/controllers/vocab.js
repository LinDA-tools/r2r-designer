'use strict';

angular.module('app')
  .controller('VocabCtrl', function ($scope, Lov) {

  $scope.vocabs = [];

  $scope.formatVocab = function (vocab) {
    if (vocab) {
      return vocab.uri;
    } else {
      return null;
    }
  };

  $scope.typeaheadLOVVocabs = function (value) {
    return Lov.getLOVVocabularies(value);
  };

  $scope.addVocab = function (vocab) {
    if (vocab.uri &&
        $scope.vocabs.map(function (i) { return i.uri; })
                     .filter(function (i) { return (i === vocab.uri); })
                     .length === 0) {
      $scope.vocabs.push(vocab);
    }
  };

  $scope.removeVocab = function (vocab) {
    $scope.vocabs.pop(vocab);
  };
});
