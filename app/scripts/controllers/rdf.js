App.RdfController = Ember.ObjectController.extend({
  needs: ['index', 'config', 'rdf', 'rdb'],

  subjectTemplate : '',
  currentColumn : '',
  currentPredicate : '',
  currentType : '',
  subjects : [],

  actions : {
    submitSubjectTemplate : function(template) {
      var table = this.get('controllers.rdb.currentTable');
      var base_uri = this.get('controllers.config.base_uri');
      var subjects = []
      
      $.ajax({
        url: 'http://localhost:3000/subjects',
        type: 'GET',
        async: false,
        data: 'table=' + table + 
              '&template=' + escape(base_uri + template),
        success: function(data) {
          var mydata = jsedn.toJS(jsedn.parse(data));
          for (var i = 0; i < mydata.length; i++) {
            subjects.addObject([mydata[i], "rdf:type", "rdfs:resource"]);
          }
        }
      });

      this.set('controllers.rdf.subjects', subjects);
    },

    mapPredicateToColumn : function() {
      // var table = 'products';
      // var column = 'ProductName';
      // var template = 'http://foo/{ProductID}'; 
      // var predicate = 'rdfs:label'; 
      var table = this.get('controllers.rdb.currentTable');
      var base_uri = this.get('controllers.config.base_uri');
      var template = base_uri + this.get('controllers.rdf.subjectTemplate');
      var predicate = this.get('controllers.rdf.currentPredicate');
      var column = this.get('controllers.rdf.currentColumn');
      var subjects = []

      $.ajax({
        url: 'http://localhost:3000/subjects',
        type: 'GET',
        async: false,
        data: 'table=' + table +
              '&template=' + escape(template) + 
              '&predicate=' + predicate +
              '&column=' + column,
        success: function(data) {
          subjects = jsedn.toJS(jsedn.parse(data));
        }
      });
  
      old_subjects = this.get('controllers.rdf.subjects');
      this.set('controllers.rdf.subjects', old_subjects.concat(subjects));
    }
  }
});
