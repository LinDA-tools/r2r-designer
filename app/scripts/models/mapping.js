App.Mapping = DS.Model.extend({
  active:     DS.attr('boolean'),
  shortname:  DS.attr('string'),
  uri:        DS.attr('string'),
});

App.Mapping.FIXTURES = [
 {
   id: 1,
   active: true,
   shortname: 'Mapping #1'
 },
 {
   id: 2,
   active: false,
   shortname: 'Mapping #2'
 },
 {
   id: 3,
   active: true,
   shortname: 'Mapping #3'
 }
];
