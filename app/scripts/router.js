R2rDesigner.Router.map(function () {
  this.resource('index', { path: '/' });
  this.resource('config');
  this.resource('rdbview');
  this.resource('rdfview');
});

R2rDesigner.IndexRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('content', model);
    this.controllerFor('config').set('content', this.store.find('config', 0));
    this.controllerFor('mappings').set('content', this.store.find('mapping'));
    this.controllerFor('vocabs').set('content', this.store.find('vocabulary'));
  }
});

R2rDesigner.ConfigRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    controller.set('content', this.store.find('config', 0));
    this.controllerFor('mappings').set('content', this.store.find('mapping'));
    this.controllerFor('vocabs').set('content', this.store.find('vocabulary'));
  }
});

R2rDesigner.MappingsRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('mapping');
  }
});

R2rDesigner.VocabsRoute = Ember.Route.extend({
  model : function() {
    return this.store.find('vocabulary');
  }
});
