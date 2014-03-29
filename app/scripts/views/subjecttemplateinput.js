App.SubjectTemplateInputView = Ember.TextField.extend({
  valueBinding : 'controller.controllers.rdf.subjectTemplate',
  classNames : 'form-control',
  placeholder : 'Ex. {CustomerId}/{Address}#_',
  action : 'submitSubjectTemplate'
});
