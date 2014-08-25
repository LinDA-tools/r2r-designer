<div ng-controller="dbContentsCtrl">
  <h3>Content of database</h3>

  {{rdb.table}}
  {{rdb.columns}}

  <div class="table-scrollable">
    <table class="table">
      <tr>
        <th ng-repeat="column in rdb.columns">
          {{column}}
        </th>
      </tr>
      <tr ng-repeat="row in data">
        <td ng-repeat="item in row track by $index">
          {{item}}
        </td>
      </tr>
    </table>
  </div>
</div>


