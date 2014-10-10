<div ng-controller="reconcileCtrl">

  <p align="right">
    <button class="btn btn-primary" ng-click="ask(table, columns)">Ask the Oracle!</button>
  </p>

  <table class="table table-scrollable">
    <tr>
      <th><a class="btn btn-sm btn-block">{{table}}</a></th>
      <th ng-repeat="column in suggestions.columns"><a class="btn btn-sm btn-block">{{column.name}}</a></th>
    </tr>

    <tr>
      <td><input type="text" class="table-input" placeholder="{{table}}" ng-model="tableTag" /></td>
      <td ng-repeat="column in suggestions.columns"><input type="text" class="table-input" placeholder="{{column.name}}" ng-model="columnTags[column.name]"/></td>
    </tr>

    <tr>
      <td>
        <div class="list-group">
          <a href="" class="list-group-item" 
             ng-repeat="i in suggestions.table.recommend" ng-click="selectClass(table, i)" ng-class="{active: isSelectedClass(table, i)}">
            {{i.prefixedName[0]}}
            <span class="score">{{i.score | score}}</span>
          </a>
        </div>
      </td>
      <td ng-repeat="column in suggestions.columns">
        <div class="list-group">
          <a href="" class="list-group-item" 
             ng-repeat="i in column.recommend" ng-click="selectProperty(table, column.name, i)" ng-class="{active: isSelectedProperty(table, column.name, i)}">
            {{i.prefixedName[0]}}
            <span class="score">{{i.score | score}}</span>
          </a>
        </div>
      </td>
    </tr>
  </table>

</div>

