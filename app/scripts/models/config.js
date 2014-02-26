R2rDesigner.Config = DS.Model.extend({
  datasource : DS.attr('string'),
  base_uri    : DS.attr('string')
  // vocabs      : DS.attr()
});

R2rDesigner.Config.FIXTURES = [{
    id          : 0,
    datasource  : 'Example SQL Database',
    base_uri     : 'http://linda-project.eu/r2r-designer/example/#'
    // mappings    : ['Mapping #1', 'Mapping #2', 'Mapping #3'],
    // vocabs      : ['Vocabulary #1', 'Vocabulary #2', 'Vocabulary #3']
  
}];

