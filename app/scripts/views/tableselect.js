App.TableSelectView = Ember.Select.extend({
  contentBinding : 'controller.controllers.rdb.tableNames',
  selectionBinding : 'controller.controllers.rdb.currentTable',
  valueBinding : 'controller.controllers.rdb.currentTable',
  classNames : 'form-control',
  prompt : 'Choose SQL Table ...',
  change : function(e) {
    var columns_map = {};
    var columns = [];
    var dataset = [];
    var table = this.get('selection');

    $.ajax({
      url: 'http://localhost:3000/columns',
      type: 'GET',
      async: false,
      data: 'table=' + table,
      success: function(data) {
        columns_map = jsedn.toJS(jsedn.parse(data));
      }
    });

    $.ajax({
      url: 'http://localhost:3000/table',
      type: 'GET',
      async: false,
      data: 'name=' + table,
      success: function(data) {
        var mydata = jsedn.parse(data);
        var column_keys = mydata.val[0].keys;
        var filter_columns = function(cols, kw) {
          var result = cols.filter(function(i) { if (i[0] == kw.name) { return true } });
          return result[0][1]
        }
        columns = column_keys.map(function (i) { return filter_columns(columns_map, i) });
        dataset = mydata.val.map(function (i) { return i.vals });
      }
    });
   
    this.set('controller.controllers.rdb.currentColumns', columns);
    this.set('controller.controllers.rdb.currentDataset', dataset); 
  }
});


