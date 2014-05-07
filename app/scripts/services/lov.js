'use strict';

angular.module('app')
  .factory('Lov', function ($http) {

    var v1Api = 'http://lov.okfn.org/dataset/lov/api/v1';
    var autocompleteApi = 'http://lov.okfn.org/dataset/lov/api/v2/autocomplete';

    return {
      getLOVTerms: function (val, type) {
        return $http.get(autocompleteApi + '/terms', {
          params: {
            q: val,
            type: type
          }
        }).then(function (res) {
          var terms = [];
          angular.forEach(res.data.results, function(item) {
            var prefix = item.prefixedName.slice(0, item.prefixedName.length - item.localName.length - 1);
            terms.push({
              uri: item.uri,
              localName: item.localName,
              prefix: prefix + ':',
              score: item.score.toPrecision(3)
            });
          });

          return terms;
        });
      },

      getLOVVocabularies: function (val) {
        return $http.get(autocompleteApi + '/vocabularies', {
          params: { q: val, }
        }).then(function (res) {
          var vocabs = [];
          angular.forEach(res.data.results, function(item) {
            vocabs.push({
              uri: item.uri,
              prefix: item.prefix,
              score: item.score.toPrecision(3)
            });
          });

          return vocabs;
        });
      },

      getAllVocabularies: function () {
        return $http.get(v1Api + '/vocabs').then(function (res) {
          var vocabs = [];
          angular.forEach(res.data.results, function(item) {
            vocabs.push({
              uri: item.uri,
              prefix: item.prefix,
              score: item.score.toPrecision(3)
            });
          });

          return vocabs;
        });
      }
    };
  });
