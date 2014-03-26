App.RdbController = Ember.ObjectController.extend({
  needs: ['index', 'config', 'datasources', 'rdb'],

  currentTable : '',
  currentColumns : [],
  currentDataset : [],

  tableNames : function() {
    var result = [];
    $.ajax({
      url: 'http://localhost:3000/tables',
      type: 'GET',
      async: false,
      success: function(data) { 
        result = jsedn.toJS(jsedn.parse(data))
      }
    });

    return result
  }(),

  actions : {
  }
});

