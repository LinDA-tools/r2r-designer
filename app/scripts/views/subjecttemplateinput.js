App.SubjectTemplateInputView = Ember.Select.extend({
  valueBinding : "controller.controllers.rdf.subjectTemplate",
  classNames : 'form-control',
  placeholder : 'Ex. {CustomerId}/{Address}#_',
  change : function(e) {
    var columns = [];
    var dataset = [];
    var table = this.get('selection');

    $.ajax({
      url: 'http://localhost:3000/subjects',
      type: 'GET',
      async: false,
      data: 'table=' + this.get('controller.controllers.rdb.currentTable') + 
            'template' + this.get('controller.controllers.rdf.subjectTemplate'),
      success: function(data) {
        var mydata = jsedn.parse(data);
        console.log(mydata);
        // columns = mydata.val[0].keys.map(function (i) { return i.val.substr(1).toUpperCase() });
        // dataset = mydata.val.map(function (i) { return i.vals });
      }
    });
  }
});
