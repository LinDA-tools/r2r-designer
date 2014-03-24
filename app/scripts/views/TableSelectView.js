R2rDesigner.TableSelectView = Ember.Select.extend({
  contentBinding : 'controller.controllers.rdb.tableNames',
  selectionBinding : 'controller.controllers.rdb.currentTable',
  valueBinding : 'controller.controllers.rdb.currentTable',
  classNames : 'form-control',
  prompt : 'Choose SQL Table ...',
  change : function(e) {
    var columns = [];
    var dataset = [];
    var table = this.get('selection');

    $.ajax({
      url: 'http://localhost:3000/table',
      type: 'GET',
      async: false,
      data: 'name=' + table,
      success: function(data) {
        var mydata = jsedn.parse(data);
        columns = mydata.val[0].keys.map(function (i) { return i.val.substr(1).toUpperCase() });
        dataset = mydata.val.map(function (i) { return i.vals });
      }
    });
   
    this.set('controller.controllers.rdb.currentColumns', columns);
    this.set('controller.controllers.rdb.currentDataset', dataset); 
  }
});


