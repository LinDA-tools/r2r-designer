/* global encodeURI:true */
'use strict';

angular.module('app')
  .factory('R2rs', function ($http, Jsedn) {

    var host = 'http://localhost:3000';
    var dbAdapter = host + '/api/v1/db';
    var lovAdapter = host + '/api/v1/lov';
    var recommenderAdapter = host + '/api/v1/recommender';

    var rowValuesToArray = function (keys, row) {
      return keys.map(function (i) { return row[i]; });
    };

    var getSuggestedEntities = function (url, params) {
      return $http.get(url, { params: params }).then(function (res) {
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
    };

    return {
      getTables: function () {
        return $http.get(dbAdapter + '/tables').then(function(res) {
          return Jsedn.toJS(Jsedn.parse(res.data));
        });
      },

      getColumnsMap: function (table) {
        return $http.get(dbAdapter + '/columns', {
          params: { table: table }
        }).then(function(res) {
          return Jsedn.toJS(Jsedn.parse(res.data));
        });
      },

      getTableData: function (table, columnsMap) {
        return $http.get(dbAdapter + '/table', {
          params: { name: table }
        }).then(function(res) {
          var columnKeys = columnsMap.map(function (i) { return i[0]; });
          var columnNames = columnsMap.map(function (i) { return i[1]; });
          var mydata = Jsedn.toJS(Jsedn.parse(res.data));
          return {
            columns: columnNames,
            data: mydata.map(function (i) { return rowValuesToArray(columnKeys, i); })
          };
        });
      },

      getSubjectsForTemplate: function (table, baseUri, template) {
        var triples = [];

        return $http.get(dbAdapter + '/subjects', {
          params: {
            table: table,
            template: encodeURI(baseUri + template)
          }
        }).then(function (res) {
          var mydata = Jsedn.toJS(Jsedn.parse(res.data));
          for (var i = 0; i < mydata.length; i++) {
            triples.push([mydata[i], 'rdf:type', 'rdfs:resource']);
          }

          return triples;
        });
      },
       
      getSuggestedLOVClasses: function (table, column) {
        return getSuggestedEntities(lovAdapter + '/classes', { table: table, column: column });
      },

      getSuggestedLOVProperties: function (table, column) {
        return getSuggestedEntities(lovAdapter + '/properties', { table: table, column: column });
      },

      getSuggestedDBPediaTypes: function (table, template) {
        return $http.get(recommenderAdapter + '/types', { params: {
          table: table,
          template: encodeURI(template)
        }}).then(function (res) {
          var suggestions = [];
          var mydata = Jsedn.toJS(Jsedn.parse(res.data));
          angular.forEach(mydata, function(item) {
            suggestions.push({
              // uri: item.uri,
              prefixedName: item.uri,
              // localName: item.uriPrefixed.slice(item.vocabularyPrefix.length + 1, item.uriPrefixed.length),
              // prefix: item.vocabularyPrefix + ':',
              // score: item.score.toPrecision(3),
              group: 'suggested'
            });
          });

          return suggestions;
        });
      },

      registerDatabase: function(dbSpec) {
        return $http.get(dbAdapter + '/config/register', {
          params: {
            subname: dbSpec.subname,
            subprotocol: dbSpec.subprotocol,
            username: dbSpec.username,
            password: dbSpec.password
          }
        });
      }
    };
  });
