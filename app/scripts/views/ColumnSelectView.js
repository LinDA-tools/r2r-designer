R2rDesigner.ColumnSelectView = Ember.Select.extend({
  contentBinding : 'controller.controllers.rdb.currentColumns',
  selectionBinding : 'controller.controllers.rdf.currentColumn',
  valueBinding : 'controller.controllers.rdf.currentColumn',
  classNames : 'form-control',
  prompt : 'Choose Column ...',
  change : function(e) {
  }
});


