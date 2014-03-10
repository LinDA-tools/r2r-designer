R2rDesigner.ConfigController = Ember.ObjectController.extend({
  needs: ['config', 'datasources', 'mappings', 'vocabs'],

  actions : {
    newDatasource : function () {
      this.set('new_ds', this.store.createRecord("Datasource", {
        name : "",
        connection_uri : "",
        classname : "",
        subprotocol : "",
        username : "",
        password : ""
      }));
    },

    saveDatasource : function (ds) {
      ds.save();
    },

    cancelNewDatasource : function (ds) {
      ds.rollback();
    }
  }
});
