App.Datasource = DS.Model.extend({
  config : DS.belongsTo('config'),
  
  name : DS.attr('string'),
  connection_uri : DS.attr('string'),
  classname : DS.attr('string'),
  subprotocol : DS.attr('string'),
  subname : DS.attr('string'),
  username : DS.attr('string'),
  password : DS.attr('string')
});

App.Datasource.FIXTURES = [{
  id : 0,
  name : 'Example MySQL Database',

  connection_uri : "",
  classname : "com.mysql.jdbc.Driver",
  subprotocol : "mysql",
  subname : "//127.0.0.1:3306/mydb",
  username : "myaccount",
  password : "secret"
},
{
  id : 1,
  name : 'Example PostgreSQL Database',

  connection_uri : "",
  classname : "??",
  subprotocol : "psql",
  subname : "//127.0.0.1:3307/mydb",
  username : "myaccount",
  password : "secret"
}];