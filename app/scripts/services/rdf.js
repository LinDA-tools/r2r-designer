'use strict';

angular.module('app')
  .factory('Rdf', function ($http, Jsedn) {
    return {
      baseProperties: [
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:label',
          localName: 'label',
          group: 'base'
        },
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:comment',
          localName: 'comment',
          group: 'base'
        },
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:seeAlso',
          localName: 'seeAlso',
          group: 'base'
        },
        {
          prefix: 'dc',
          prefixedName: 'dc:title',
          localName: 'title',
          group: 'base'
        },
        {
          prefix: 'skos',
          prefixedName: 'skos:prefLabel',
          localName: 'prefLabel',
          group: 'base'
        },
        {
          prefix: 'skos',
          prefixedName: 'skos:altLabel',
          localName: 'altLabel',
          group: 'base'
        }
      ],

      baseTypes: [
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:Resource',
          localName: 'Resource',
          group: 'base'
        },
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:Literal',
          localName: 'Literal',
          group: 'base'
        },
        {
          prefix: 'rdfs',
          prefixedName: 'rdfs:Class',
          localName: 'Class',
          group: 'base'
        },
        {
          prefix: 'skos',
          prefixedName: 'skos:Concept',
          localName: 'Concept',
          group: 'base'
        }
      ],
        
      getLOVEntities: function (val, type) {
        return $http.get('http://lov.okfn.org/dataset/lov/api/v2/autocomplete/terms', {
          params: {
            q: val,
            type: type
          }
        }).then(function (res) {
          var entities = [];
          angular.forEach(res.data.results, function(item) {
            var prefix = item.prefixedName.slice(0, item.prefixedName.length - item.localName.length - 1);
            entities.push({
              uri: item.uri,
              localName: item.localName,
              prefix: prefix + ':',
              score: item.score.toPrecision(3)
            });
          });

          return entities;
        });
      },

      getSuggestedProperties: function (column) {
        return $http.get('http://localhost:3000/api/v1/lov/properties', {
          params: { column: column }
        }).then(function (res) {
          var suggestions = [];
          var mydata = Jsedn.toJS(Jsedn.parse(res.data));
          angular.forEach(mydata, function(item) {
            suggestions.push({
              uri: item.uri,
              prefixedName: item.uriPrefixed,
              localName: item.uriPrefixed.slice(item.vocabularyPrefix.length + 1, item.uriPrefixed.length),
              prefix: item.vocabularyPrefix + ':',
              score: item.score.toPrecision(3),
              group: 'suggested'
            });
          });

          return suggestions;
        });
      }
    };
  });

            // if (prefixMap[prefix] === undefined) {
            //   $http.get('http://lov.okfn.org/dataset/lov/api/v2/autocomplete/vocabularies', {
            //     params: {
            //       q: prefix
            //     }
            //   }).then(function (res) {
            //     prefixMap[prefix] = res.data.results[0].uri;
            //   });
            // }
