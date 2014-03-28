App.RdfController = Ember.ObjectController.extend({
  needs: ['index', 'rdf', 'rdb'],

  subjectTemplate : 'http://linda-project.eu/{ProductName}/{ProductID}/',
  currentColumn : '',
  currentPredicate : '',
  subjects : [],

  actions : {
    submitSubjectTemplate : function(template) {
      var table = this.get('controllers.rdb.currentTable');
      console.log(table);
      var subjects = []

      $.ajax({
        url: 'http://localhost:3000/subjects',
        type: 'GET',
        async: false,
        data: 'table=' + table + 
              '&template=' + template,
        success: function(data) {
          var mydata = jsedn.toJS(jsedn.parse(data));
          for (var i = 0; i < mydata.length; i++) {
            console.log(mydata[i]);
            subjects.addObject([mydata[i], "rdf:type", "rdfs:resource"]);
          }
        }
      });

      this.set('controllers.rdf.subjects', subjects);
    }
  }
});


