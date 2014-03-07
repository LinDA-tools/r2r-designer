R2rDesigner.Config = DS.Model.extend({
  base_uri : DS.attr('string'),
  current_ds : DS.attr('datasource'),
  datasources : DS.hasMany('datasource')
  // vocabs      : DS.attr()
});

R2rDesigner.Config.FIXTURES = [{
  id : 0,
  base_uri : 'http://linda-project.eu/r2r-designer/example/#',

  current_ds : {
    id : 1,
    name : 'Example PostgreSQL Database',

    connection_uri : "",
    classname : "??",
    subprotocol : "psql",
    subname : "//127.0.0.1:3307/mydb",
    username : "myaccount",
    password : "secret"
  }
}];

