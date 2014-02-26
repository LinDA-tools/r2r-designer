R2rDesigner.VocabsController = Ember.ArrayController.extend({
  active : Ember.computed.filterBy('content', 'active', true),
  remaining : Ember.computed.filterBy('content', 'active', false)
});

