<div class="main container" ng-controller="MainCtrl">

  <div class="header">
    <ul class="nav nav-pills pull-right">
      <li class="active"><a ng-href="#">Home</a></li>
      <li><a ng-href="#">About</a></li>
      <li><a ng-href="#">Contact</a></li>
    </ul>
    <h3 class="text-muted">{{title}}</h3>
  </div>

  <wizard>
    <step name="welcome"
          heading="Transforming Relational Data to Linked Data"
          description="example description">
      Hi there!
    </step>

    <step name="datasource configuration"
          heading="Datasource Configuration"
          description="example description">
      <div ng-include src="'partials/config.html.tpl'"></div>
    </step>

    <step name="database contents"
          heading="Database Contents"
          description="example description">
      <div ng-include src="'partials/dbcontents.html.tpl'"></div>
    </step>

    <step name="reconciliation"
          heading="Reconcile Database Structure"
          description="">
      <div ng-include src="'partials/reconcile.html.tpl'"></div>
    </step>

    <step name="publishing"
          heading="Publish as SPARQL endpoint"
          description="">
      <button>Publish</button>
    </step>
  </wizard>
</div>
