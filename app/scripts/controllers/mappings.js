R2rDesigner.MappingsController = Ember.ArrayController.extend({
  active : Ember.computed.filterBy('content', 'active', true),
  remaining : Ember.computed.filterBy('content', 'active', false)
});
