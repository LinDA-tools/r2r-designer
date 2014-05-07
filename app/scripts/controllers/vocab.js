'use strict';

var VocabModalInstanceCtrl = function ($scope, $modalInstance, title, items) {

  $scope.title = title;
  $scope.items = items;

  $scope.select = function (vocab) {
    $modalInstance.close(vocab);
  };

  // $scope.ok = function () {
  //   $modalInstance.close($scope.selected);
  // };

  // $scope.cancel = function () {
  //   $modalInstance.dismiss('cancel');
  // };
};

angular.module('app')
  .controller('VocabCtrl', function ($scope, $modal, Lov, Vocab) {

  $scope.vocabs = Vocab.vocabs;

  $scope.typeaheadLOVVocabs = function (value) {
    return Lov.getLOVVocabularies(value);
  };

  $scope.addVocab = function (vocab) {
    if (vocab && vocab.uri &&
        $scope.vocabs.map(function (i) { return i.uri; })
                     .filter(function (i) { return (i === vocab.uri); })
                     .length === 0) {
      $scope.vocabs.push(vocab);
    }
  };

  $scope.removeVocab = function (vocab) {
    $scope.vocabs.pop(vocab);
  };

  $scope.searchVocab = function () {
    var modalInstance = $modal.open({
      templateUrl: 'partials/search_vocab.html',
      controller: VocabModalInstanceCtrl,
      resolve: {
        items: function () {
          return Lov.getLOVVocabularies('a');
        },
        title: function () {
          return 'Select suitable vocabularies';
        }
      }
    });

    modalInstance.result.then(function (selected) {
      $scope.addVocab(selected);
    });
  };
});
