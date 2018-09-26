var lang = {
		
"language" : "en",

"site" : {
  "parameter" : "Parameter",
  "parameterTitle" : "Choose parameter",
  "station" : "Station",
  "stationTitle" : "Choose station or station group",
  "beginDate" : "Start date", 
  "beginDateTitle" : "Choose starting date of period",
  "endDate" : "End date",	
  "endDateTitle" : "Choose ending date of period",
  "graphSelector" : "Presentation",
  "graphSelectorValue" : "Graph",	
  "graphSelectorTitle" : "Choose graph output",
  "tableSelectorValue" : "Table",	
  "tableSelectorTitle" : "Choose tabular output",
  "hourName" : "Hour",
  "dayName" : "Day",
  "time" : "Time",
  "download" : "Download file",
  "oneHourSelector" : "Time interval",
  "oneHourSelectorValue" : "1h",
  "oneHourSelectorTitle" : "Choose hourly pollutants",
  "eightHourSelectorValue" : "8h",
  "eightHourSelectorTitle" : "Choose eight hour average pollutants",
  "twentyFourHourSelectorValue" : "24h",
  "twentyFourHourSelectorTitle" : "Choose daily average pollutants",
},

"parameters" : {
  "CO"   : [ 
          { 
           "name" : "Carbon Monoxide (CO)" ,
	         "unit" : "mg/m<sup>3</sup>" ,	
	         "shortName" : "CO",
           "aggregationHour": "1",
           "airViroName" : "CO"
          },
          { 
           "name" : "Carbon Monoxide (CO) 8-hour average" ,
           "unit" : "mg/m<sup>3</sup>" ,  
           "shortName" : "CO",
           "aggregationHour": "8",
           "airViroName" : "CO8H",
           "limitValue" : "10"
          }
         ],
  "NO2"  : [
          { 
             "name" : "Nitrogen Dioxide (NO<sub>2</sub>)" ,
             "unit" : "µg/m<sup>3</sup>" ,	
    	       "shortName" : "NO<sub>2</sub>",
             "aggregationHour": "1",
             "airViroName" : "NO2",
             "limitValue" : "200"
         }
         ],
  "O3"   : [
          { "name" : "Ozone (O<sup>3</sup>)",
             "unit" : "µg/m<sub>3</sub>",
             "shortName" : "O<sub>3</sub>",
             "aggregationHour": "1",
             "airViroName" : "O3"
         },
         { "name" : "Ozone (O<sup>3</sup>) 8-hour average",
             "unit" : "µg/m<sub>3</sub>",
             "shortName" : "O<sub>3</sub>",
             "aggregationHour": "8",
             "airViroName" : "O38H"
         }
         ],
  "PM10" : [
          { "name" : "Particulate Matter (PM<sub>10</sub>)",
	         "unit" : "µg/m<sup>3</sup>",
	         "shortName" : "PM<sub>10</sub>",
           "aggregationHour": "1",
           "airViroName" : "PM10"
         },
         { "name" : "Daily Particulate Matter (PM<sub>10</sub>)",
           "unit" : "µg/m<sup>3</sup>",
           "shortName" : "PM<sub>10</sub>",
           "aggregationHour": "24",
           "airViroName" : "PM10D",
           "limitValue" : "50"
         }
         ],
  "PM25" : [
          { "name" : "Particulate Matter (PM<sub>2.5</sub>)",
	         "unit" : "µg/m<sup>3</sup>",
	         "shortName" : "PM<sub>2.5</sub>",
           "aggregationHour": "1",
           "airViroName" : "PM25"
         }
         ],
  "SO2" :  [
          { "name" : "Sulfur Dioxide (SO<sub>2</sub>)",
	         "unit" : "µg/m<sup>3</sup>",
	         "shortName" : "SO<sub>2</sub>",
           "aggregationHour": "1",
           "airViroName" : "SO2",
           "limitValue" : "350"
         },
          { "name" : "Daily Sulfur Dioxide (SO<sub>2</sub>)",
           "unit" : "µg/m<sup>3</sup>",
           "shortName" : "SO<sub>2</sub>",
           "aggregationHour": "24",
           "airViroName" : "SO2D",
           "limitValue" : "125"
         }
         ],
},

"stations" : {
	
  "Centar" : { "name" : "Centar", "lat": 41.99249998, "lng": 21.42361109, "zoom": 12  },
  "Karpos" : { "name" : "Karpos", "lat": 42.00666664, "lng": 21.38694446, "zoom": 12 },
  "Lisice" : { "name" : "Lisice", "lat": 41.9783, "lng": 21.47, "zoom": 12 },
  "GaziBaba" : { "name" : "Gazi Baba", "lat": 42.0036, "lng": 21.4636, "zoom": 12 },
  "Rektorat" : { "name" : "Rektorat", "lat": 41.9992, "lng": 21.4408, "zoom": 12 },
  "Miladinovci" : { "name" : "Miladinovci", "lat": 41.9875, "lng": 21.6525, "zoom": 12 },
  "Mobile" : { "name" : "Mobile station-Butel", "lat": 42.031384, "lng": 21.447702, "zoom": 12 },
    
  "Bitola1" : { "name" : "Bitola 1", "lat": 41.04, "lng": 21.3564, "zoom": 12 },
  "Bitola2" : { "name" : "Bitola 2", "lat": 41.0303, "lng": 21.3367, "zoom": 12 },
  "Kicevo" : { "name" : "Kicevo", "lat": 41.5144, "lng": 20.9586, "zoom": 10 },
  "Lazaropole" : { "name" : "Lazaropole", "lat": 41.5358, "lng": 20.6989, "zoom": 10 },
  "Tetovo" : { "name" : "Tetovo", "lat": 42.0044, "lng": 20.9681, "zoom": 10 },
  "Gostivar" : { "name" : "Gostivar", "lat": 41.799742, "lng": 20.909739, "zoom": 10 },

  "Veles2" : { "name" : "Veles 2", "lat": 41.7058, "lng": 21.7653, "zoom": 12 },
  "Kocani" : { "name" : "Kocani", "lat": 41.9139, "lng": 22.4158, "zoom": 10  },
  "Kavadarci" : { "name" : "Kavadarci", "lat": 41.4406, "lng": 22.0072, "zoom": 10 },
  "Kumanovo" : { "name" : "Kumanovo", "lat": 42.1356, "lng": 21.7147, "zoom": 10 },
  "Strumica" : { "name" : "Strumica", "lat": 41.439137, "lng": 22.643160, "zoom": 10 },
 
  "SkopjeRegion" : { "name" : "Skopje Agglomeration" },
  "WesternRegion" : { "name" : "Western Zone" },
  "EasternRegion" : { "name" : "Eastern Zone" }
		
},

"levels" : ["Missing", "VeryLow", "Low", "Medium", "High", "VeryHigh"],

"graph" : {
  "hourlyTitle" : "Hourly %s concentrations for %s",
  "eightHourlyTitle" : "Eight hour %s concentrations for %s",
  "dailyTitle" : "Daily %s concentrations for %s",
  "limitValue" : "Limit: %s %s",
  "maximumEightHourTooltip" : "Maximum 8 hour average for %s<br/>%s %s %s at %s"
},

"table" : {
  "hourlyTitle" : "Hourly %s concentrations (%s)",
  "eightHourlyTitle" : "Eight hour %s concentrations (%s)",
  "dailyTitle" : "Daily %s concentrations (%s)"
},

"map" : {
  "wholeMacedonia" : "Republic of Macedonia",
  "worstPollutant" : "Pollutant with the highest concentration"
},

"weekDays": [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun'
],

"shortMonths": [
 'Јan',
 'Feb',
 'Маr',
 'Apr',
 'May',
 'Јun',
 'Јul',
 'Aug',
 'Sep',
 'Оct',
 'Nov',
 'Dec'
],

"months": [
 'January',
 'February',
 'Маrch',
 'April',
 'Маy',
 'Јune',
 'Јuly',
 'August',
 'September',
 'Оctober',
 'November',
 'December'
]
}