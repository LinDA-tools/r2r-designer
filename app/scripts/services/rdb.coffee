'use strict'
angular.module 'app'
	.factory 'RdbFactory', ->
		tables : [{
			tableName: "table1"
			enlist: true
			columns: [{colName:"col1_1"
			colType : "INT"
			colPreference : ["auto-inc","NOT NULL"]
			predictions : ["kartoffel", "donut"]
			enlist: false
			},
			{colName:"col1_2"
			colType : "VARCHAR"
			colPreference : ["NOT NULL"]
			predictions : ["brokoli", "senf"]
			enlist: true
			}]
		},
		{
			tableName: "table2"
			enlist: true
			columns: [{colName:"col2_1"
			colType : "INT"
			enlist: true
			},
			{colName:"col2_2"
			colType : "SOME"
			enlist: true
			}]
		},
		{
			tableName: "table3"
			enlist: false
			columns: [{colName:"col3_1"
			colType : "INT"
			enlist: true
			}]
		}]



		#DUMMY FACTORY