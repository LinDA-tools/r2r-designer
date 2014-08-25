<div ng-controller="PlaygroundCtrl">
  <h3>Playground</h3>

  <div class="panel panel-default">
    <div class="panel-body">
      <p align="right">
        <button class="btn btn-primary">
          Ask the Oracle!
        </button>
      </p>
    </div>

    <table class="table table-scrollable">
      <tr>
        <!-- table -->
        <th><button type="button" class="btn btn-primary btn-sm btn-block">{{table}}</button></th>
        <!-- columns -->
        <th ng-repeat="column in columns"><button type="button" class="btn btn-default btn-sm btn-block">{{column}}</button></th>
      </tr>

      <tr>
        <!-- table -->
        <td><input type="text" class="table-input" placeholder="search words, e.&nbsp;g. '{{table}}'" /></td>
        <!-- columns -->
        <td ng-repeat="column in columns"><input type="text" class="table-input" placeholder="search words, e.&nbsp;g. '{{column}}'" /></td>
      </tr>

      <tr>
        <!-- table -->
        <td>
          <div class="list-group">
            <button type="button" class="btn btn-sm btn-default btn-block active">Cras justo odio</button>
            <button type="button" class="btn btn-sm btn-default btn-block">Dapibus ac facilisis in</a>
            <button type="button" class="btn btn-sm btn-default btn-block active">Morbi leo risus</a>
            <button type="button" class="btn btn-sm btn-default btn-block">Porta ac consectetur ac</a>
            <button type="button" class="btn btn-sm btn-default btn-block active">Vestibulum at eros</a>
          </div>
        </td>
        <!-- columns -->
        <td ng-repeat="column in columns">
        </td>
      </tr>
    </table>

  <!-- <table class="table table&#45;scrollable"> -->
  <!--   <tr ng&#45;repeat="table in tables"> -->
  <!--     <th class="btn&#45;th"> -->
  <!--       <button type="button"  -->
  <!--               class="btn btn&#45;primary btn&#45;sm table&#45;btn"  -->
  <!--               ng&#45;class="{active: isSelectedTable(table)}" -->
  <!--               ng&#45;click="toggleSelectTable(table)">  -->
  <!--         {{table}} -->
  <!--       </button> -->
  <!--     </th> -->
  <!--     <td> -->
  <!--       <button ng&#45;repeat="column in tableColumns[table]"  -->
  <!--               type="button"  -->
  <!--               class="btn btn&#45;default btn&#45;sm table&#45;btn" -->
  <!--               ng&#45;class="{disabled: !isSelectedTable(table), active: isSelectedColumn(table, column)}" -->
  <!--               ng&#45;click="toggleSelectColumn(table, column)"> -->
  <!--           {{column}} -->
  <!--       </button> -->
  <!--     </td> -->
  <!--   </tr> -->
  <!-- </table> -->

  <!-- <div> -->
  <!--   <b>Tables:</b> -->
  <!--   <table class="table table&#45;scrollable"> -->
  <!--     <tr> -->
  <!--       <th ng&#45;repeat="i in tables"> -->
  <!--         {{i}} -->
  <!--       </th> -->
  <!--     </tr> -->
  <!--   </table> -->
  <!-- </div> -->
</div>
