R2rDesigner.ConfigController = Ember.ObjectController.extend({
  needs : ['config', 'datasources', 'mappings', 'vocabs'],

  current_ds_id : 0,
  current_ds : function () {
    return this.get('datasources').then(function(items) {
      var names = items.map(function(item) {
        console.log(item);
        console.log(item.name);
        return item.name
      });
      return names 
    })
  }.property()
});
