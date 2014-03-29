App.TypeSelectView = Ember.Select.extend({
  content : [
    'rdf:XMLLiteral',
    'rdf:Property',
    'rdf:Statement',
    'rdf:Alt', 
    'rdf:Bag', 
    'rdf:Seq',
    'rdf:List',
    'rdf:nil',
    'rdfs:Resource',
    'rdfs:Literal',
    'rdfs:Class',
    'rdfs:Datatype',
    'rdfs:Container',
    'rdfs:ContainerMembershipProperty'
  ],
  selectionBinding : 'controller.controllers.rdf.currentType',
  // valueBinding : '',
  classNames : 'form-control',
  prompt : '<rdfs:class>',
  change : function(e) {
  }
});

