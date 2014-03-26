App.Vocabulary = DS.Model.extend({
  active:     DS.attr('boolean'),
  shortname:  DS.attr('string'),
  uri:        DS.attr('string'),
});

App.Vocabulary.FIXTURES = [
 {
   id: 1,
   active: false,
   shortname: 'Vocabulary #1'
 },
 {
   id: 2,
   active: true,
   shortname: 'Vocabulary #2'
 },
 {
   id: 3,
   active: false,
   shortname: 'Vocabulary #3'
 }
];

