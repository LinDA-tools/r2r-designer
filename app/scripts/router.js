App.Router.map(function () {
  this.resource('index', { path: '/' });
  this.resource('config', function () {
    this.route('datasource');
  });
  this.resource('datasource', { path: '/datasource/:id' });
  this.resource('rdb');
  this.resource('rdf');
});

App.IndexRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('content', model);
    this.controllerFor('config').set('content', this.store.find('config', 0));
    this.controllerFor('datasources').set('content', this.store.find('datasource'));
    this.controllerFor('mappings').set('content', this.store.find('mapping'));
    this.controllerFor('vocabs').set('content', this.store.find('vocabulary'));
    this.controllerFor('rdb').set('content', this.store.find('rdb', 0));
  },
  actions : {
    submitSubjectTemplate : function(e) {
      this.controllerFor('rdf').send('submitSubjectTemplate', e);
    }
  }
});

App.ConfigRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('content', this.store.find('config', 0));
    this.controllerFor('datasources').set('content', this.store.find('datasource'));
    this.controllerFor('mappings').set('content', this.store.find('mapping'));
    this.controllerFor('vocabs').set('content', this.store.find('vocabulary'));
  }
});

App.DatasourceRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('datasource', params.id);
  }
});

App.DatasourcesRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('datasource');
  }
});

App.MappingsRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('mapping');
  }
});

App.VocabsRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('vocabulary');
  }
});

App.RdbRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('rdb');
  }
});
