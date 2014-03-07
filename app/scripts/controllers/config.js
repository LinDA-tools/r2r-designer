R2rDesigner.ConfigController = Ember.ObjectController.extend({
  needs: ['config', 'datasources', 'mappings', 'vocabs'],

  new_ds : null,

  actions : {
    newDatasource : function () {
      this.new_ds = this.store.createRecord("Datasource", {
        name : "",
        connection_uri : "",
        classname : "",
        subprotocol : "",
        username : "",
        password : ""
      });
    },

    saveDatasource : function (new_ds) {
      console.log(new_ds);
      console.log(this.get('new_ds'));
      this.get('new_ds').save();
      this.set('current_ds', this.get('new_ds'));
    }
  }
});
