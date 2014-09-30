'use strict'
angular.module 'app'
	.factory 'RdbFactory', ->
		tables : [{
			tableName: "table1"
			enlist: true
			columns: [{colName:"col1_1"
			colType : "INT"
			colPreference : ["auto-inc","NOT NULL"]
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			predictions : ["kartoffel", "donut"]
			enlist: false
			},
			{colName:"col1_2"
			colType : "VARCHAR"
			colPreference : ["NOT NULL"]
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			predictions : ["brokoli", "senf"]
			enlist: true
			}]
		},
		{
			tableName: "table2"
			enlist: true
			columns: [{colName:"col2_1"
			colType : "INT"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			enlist: true
			},
			{colName:"col2_2"
			colType : "VARCHAR"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			enlist: true
			},
			{colName:"col2_3"
			colType : "ENUM"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			enlist: true
			},
			{colName:"col2_4"
			colType : "SOME"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			enlist: true
			}]
		},
		{
			tableName: "table3"
			enlist: false
			columns: [{colName:"col3_1"
			colType : "INT"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			enlist: true
			}]
		}]



		#DUMMY FACTORY

