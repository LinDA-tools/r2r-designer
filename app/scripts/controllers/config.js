R2rDesigner.ConfigController = Ember.ObjectController.extend({
  needs: ['config', 'datasources', 'mappings', 'vocabs', 'rdb'],

  new_name: "",
  new_connection_uri: "",
  new_classname: "",
  new_subprotocol: "",
  new_subname: "",
  new_username: "",
  new_password: "",

  actions : {

    newDatasource : function () {
      this.set('controllers.config.new_name', ""),
      this.set('controllers.config.new_connection_uri', ""),
      this.set('controllers.config.new_classname', "", ""),
      this.set('controllers.config.new_subprotocol', ""),
      this.set('controllers.config.new_subname', ""),
      this.set('controllers.config.new_username', ""),
      this.set('controllers.config.new_password', "")
    },

    saveNewDatasource : function () {
      var new_ds = this.store.createRecord("Datasource", {
        name : this.get('controllers.config.new_name'),
        connection_uri : this.get('controllers.config.new_connection_uri'),
        classname : this.get('controllers.config.new_classname'),
        subprotocol : this.get('controllers.config.new_subprotocol'),
        subname : this.get('controllers.config.new_subname'),
        username : this.get('controllers.config.new_username'),
        password : this.get('controllers.config.new_password')
      });
      this.get('controllers.config.datasources').addObject(new_ds);
      this.set('controllers.config.current_ds', new_ds);
    },

    saveDatasource : function (ds) {
      if (ds) {
        ds.save();
      }
    },

    cancelDatasource : function (ds) {
      if (ds) {
        ds.rollback();
      }
    }
  }
});
