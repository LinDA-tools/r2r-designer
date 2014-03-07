R2rDesigner.DatasourceController = Ember.ObjectController.extend({
  // name : "",
  // connection_uri : "",
  // classname : "",
  // subprotocol : "",
  // subname : "",
  // user : "",
  // password : "",

  actions : {
    createDatasource : function () {
      var ds = this.store.createRecord("Datasource", {
        name : this.name,
        connection_uri : this.connection_uri,
        classname : this.classname,
        subprotocol : this.subprotocol,
        username : this.username,
        password : this.password
      });

      ds.save();
    },

    editDatasource : function () {
    }
  }
});
