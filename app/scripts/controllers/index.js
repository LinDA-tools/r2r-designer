App.IndexController = Ember.Controller.extend({
  needs: ['config', 'datasources', 'datasource', 'mappings', 'vocabs', 'rdb', 'rdf'],
  title: 'R2R Mapping Designer'
});

