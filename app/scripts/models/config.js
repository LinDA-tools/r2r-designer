R2rDesigner.Config = DS.Model.extend({
  current_ds : DS.attr('integer'),
  base_uri    : DS.attr('string'),

  datasources : DS.hasMany('datasource')
  // vocabs      : DS.attr()
});

R2rDesigner.Config.FIXTURES = [{
  id : 0,
  base_uri : 'http://linda-project.eu/r2r-designer/example/#',

  // mappings    : ['Mapping #1', 'Mapping #2', 'Mapping #3'],
  // vocabs      : ['Vocabulary #1', 'Vocabulary #2', 'Vocabulary #3']
}];

