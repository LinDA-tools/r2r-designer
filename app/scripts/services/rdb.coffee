'use strict'
angular.module 'app'
	.factory 'RdbFactory', ->

		#DUMMY FACTORY
		# how to build restful client with $ressource
		# https://docs.angularjs.org/tutorial/step_11

		###
		predictions : [
          	{
            "prefixedName":["umbel:Products"],
            "uri":["http://umbel.org/umbel#Products"],
            "score":0.5555555
          	}
		###
		tables : [{
			tableName: "table1"
			columns: [{colName:"col1_1"
			colType : "INT"
			colPreference : ["auto-inc","NOT NULL"]
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]			
			},
			{
			colName:"col1_2"
			colType : "VARCHAR"
			colPreference : ["NOT NULL"]
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			}
			]
		},
		{
			tableName: "table2"
			columns: [{colName:"col2_1"
			colType : "INT"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			},
			{colName:"col2_2"
			colType : "VARCHAR"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			},
			{colName:"col2_3"
			colType : "ENUM"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			},
			{colName:"col2_4"
			colType : "SOME"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			}
			]
		},
		{
			tableName: "table3"
			columns: [{colName:"col3_1"
			colType : "INT"
			sampleValues : ["sampleVal1", "sampleVal2", "sampleVal3", "sampleVal4", "sampleVal5"]
			}
			]
		}]