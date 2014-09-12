'use strict'

VocabModalInstanceCtrl = ($scope, $modalInstance, title, items) ->

  $scope.title = title
  $scope.items = items

  $scope.select = (vocab) ->
    $modalInstance.close vocab

angular.module 'app'
  .controller 'VocabCtrl', ($scope, $modal, Vocab) ->
    $scope.vocabs = Vocab.vocabs

    $scope.addVocab = (vocab) ->
      if vocab and vocab.uri and
         (v for v in $scope.vocabs when v.uri == vocab.uri).length == 0
        $scope.vocabs.push(vocab)

    $scope.removeVocab = (vocab) ->
      $scope.vocabs.pop vocab

    $scope.searchVocab = ->
      modalInstance = $modal.open
        templateUrl: 'partials/search_vocab.html'
        controller: VocabModalInstanceCtrl
        resolve:
          title: ->
            'Select suitable vocabularies'

      modalInstance.result.then (selected) ->
        $scope.addVocab selected
