App.PredicateSelectView = Ember.Select.extend({
  content : [
      'rdf:type',
      'rdf:first',
      'rdf:rest',
      'rdf:value',
      'rdf:subject',
      'rdf:predicate',
      'rdf:object',
      'rdfs:subClassOf',
      'rdfs:subPropertyOf',
      'rdfs:domain',
      'rdfs:range',
      'rdfs:label',
      'rdfs:comment',
      'rdfs:member',
      'rdfs:seeAlso',
      'rdfs:isDefinedBy'
  ],
  selectionBinding : 'controller.controllers.rdf.currentPredicate',
  // valueBinding : '',
  classNames : 'form-control',
  prompt : '<rdf:predicate>',
  change : function(e) {
  }
});

