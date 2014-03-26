App.Config = DS.Model.extend({
  base_uri : DS.attr('string'),
  current_ds : DS.attr('datasource'),
  datasources : DS.hasMany('datasource')
});

App.Config.FIXTURES = [{
  id : 0,
  base_uri : '',

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

