<div ng-controller="reconcileCtrl">

  <!-- <div class="panel panel&#45;default"> -->
  <!--   <div class="panel&#45;body"> -->
      <p align="right">
        <button class="btn btn-primary" ng-click="ask(table, columns)">
          Ask the Oracle!
        </button>
      </p>
    <!-- </div> -->

    <table class="table table-scrollable">
      <tr>
        <th><button type="button" class="btn btn-primary btn-sm btn-block">{{table}}</button></th>
        <th ng-repeat="column in suggestions.columns"><button type="button" class="btn btn-default btn-sm btn-block">{{column.name}}</button></th>
      </tr>

      <tr>
        <td><input type="text" class="table-input" placeholder="{{table}}" ng-model="tableTag" /></td>
        <td ng-repeat="column in suggestions.columns"><input type="text" class="table-input" placeholder="{{column.name}}" ng-model="columnTags[$index]"/></td>
      </tr>

      <tr>
        <td>
          <div class="list-group">
            <a href="#" class="list-group-item" ng-repeat="i in suggestions.table.recommend">
              {{i.prefixedName[0]}}
              <span class="score">{{i.score | score}}</span>
            </a>
          </div>
        </td>
        <td ng-repeat="column in suggestions.columns">
          <div class="list-group">
            <a href="#" class="list-group-item" ng-repeat="i in column.recommend">
              {{i.prefixedName[0]}}
              <span class="score">{{i.score | score}}</span>
            </a>
          </div>
        </td>
      </tr>
    </table>
  <!-- </div> -->

</div>

