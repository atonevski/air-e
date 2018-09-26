var lang = {

"language" : "mk",

"site" : {
  "parameter" : "Параметар",
  "parameterTitle" : "Загадувачка супстанца",
  "station" : "Станица",
  "stationTitle" : "Станица",
  "beginDate" : "почетен датум",  
  "beginDateTitle" : "од",
  "endDate" : "Краен датум",	
  "endDateTitle" : "До",
  "graphSelector" : "презентација",
  "graphSelectorValue" : "График",	
  "graphSelectorTitle" : "График",
  "tableSelectorValue" : "Табела",	
  "tableSelectorTitle" : "Табела",
  "hourName" : "Часовни",
  "dayName" : "Дневно",
  "time" : "време",
  "download" : "преземи датотека",
  "oneHourSelector" : "временски интервал",
  "oneHourSelectorValue" : "1ч",
  "oneHourSelectorTitle" : "изберете часовните загадувачи",
  "eightHourSelectorValue" : "8ч",
  "eightHourSelectorTitle" : "изберете осумчасовна средна загадувачи",
  "twentyFourHourSelectorValue" : "24ч",
  "twentyFourHourSelectorTitle" : "изберете просечната дневна загадувачи",
},

"parameters" : {
  "CO"   : [
        { "name" : "Јаглерод Моноксид (CO)" ,
	         "unit" : "mg/m<sup>3</sup>",	
	         "shortName" : "CO",
                 "aggregationHour" : "1",
	         "airViroName" : "CO"
        },
        { 
           "name" : "Јаглерод Моноксид (CO) 8-часовен просек" ,
           "unit" : "mg/m<sup>3</sup>" ,  
           "shortName" : "CO",
           "aggregationHour": "8",
           "airViroName" : "CO8H",
           "limitValue" : "10"
          }
        ],
  "NO2"  : [
        { "name" : "Азот Диоксид (NO<sub>2</sub>)" ,
  	         "unit" : "µg/m<sup>3</sup>" ,	
  	         "shortName" : "NO<sub>2</sub>",
                 "aggregationHour" : "1",
  	         "airViroName" : "NO2",
                 "limitValue" : "200"
        },
        ],
  "O3"  : [
          { "name" : "Озон (O<sub>3</sub>)",
             "unit" : "µg/m<sup>3</sup>",
             "shortName" : "O<sub>3</sub>",
             "aggregationHour" : "1",
             "airViroName" : "O3"   
          },
          { "name" : "Озон (O<sub>3</sub>) 8-часовен просек",
             "unit" : "µg/m<sup>3</sup>",
             "shortName" : "O<sub>3</sub>",
             "aggregationHour" : "8",
             "airViroName" : "O38H"   
          },
          ],
  "PM10" : [
            { "name" : "Суспендирани Честички (PM<sub>10</sub>)",
	           "unit" : "µg/m<sup>3</sup>",
	           "shortName" : "PM<sub>10</sub>",
             "aggregationHour" : "1",
	           "airViroName": "PM10"
	          },
            { "name": "Суспендирани Честички (PM<sub>10</sub>) Дневно",
              "unit" : "µg/m<sup>3</sup>",
              "shortName" : "PM<sub>10</sub>",
              "aggregationHour" : "24",
              "airViroName" : "PM10D",
              "limitValue" : "50"
            }
            ],
  "PM25" : [
            { "name" : "Суспендирани Честички (PM<sub>2.5</sub>)",
	           "unit" : "µg/m<sup>3</sup>",
	           "shortName" : "PM<sub>2.5</sub>",
             "aggregationHour" : "1",
	           "airViroName" : "PM25"
         }
         ],
  "SO2" : [
            { "name" : "Сулфур Диоксид (SO<sub>2</sub>)",
	           "unit" : "µg/m<sup>3</sup>",
	           "shortName" : "SO<sub>2</sub>",
             "aggregationHour" : "1",
	    	     "airViroName" : "SO2"   
         },
         { "name" : "Сулфур Диоксид (SO<sub>2</sub>) Дневно",
           "unit" : "µg/m<sup>3</sup>",
           "shortName" : "SO<sub>2</sub>",
           "aggregationHour": "24",
           "airViroName" : "SO2D",
           "limitValue" : "125"
         }
         ]
},

"stations" : {

  "Centar" : { "name" : "Центар", "lat": 41.99249998, "lng": 21.42361109, "zoom": 12 },
  "Karpos" : { "name" : "Карпош", "lat": 42.00666664, "lng": 21.38694446, "zoom": 12},
  "Lisice" : { "name" : "Лисиче", "lat": 41.9783, "lng": 21.47, "zoom": 12},
  "GaziBaba" : { "name" : "Гази Баба", "lat": 42.0036, "lng": 21.4636, "zoom": 12},
  "Rektorat" : { "name" : "Ректорат", "lat": 41.9992, "lng": 21.4408, "zoom": 12},
  "Miladinovci" : { "name" : "Миладиновци", "lat": 41.9875, "lng": 21.6525, "zoom": 12 },
  "Mobile" : { "name" : "Мобилна станица-Бутел", "lat": 42.031384, "lng": 21.447702, "zoom": 12 },
    
  "Bitola1" : { "name" : "Битола 1", "lat": 41.04, "lng": 21.3564, "zoom": 12 },
  "Bitola2" : { "name" : "Битола 2", "lat": 41.0303, "lng": 21.3367, "zoom": 12 },
  "Kicevo" : { "name" : "Кичево", "lat": 41.5144, "lng": 20.9586, "zoom": 10 },
  "Lazaropole" : { "name" : "Лазарополе", "lat": 41.5358, "lng": 20.6989, "zoom": 10 },
  "Tetovo" : { "name" : "Тетово", "lat": 42.0044, "lng": 20.9681, "zoom": 10 },
  "Gostivar" : { "name" : "Гостивар", "lat": 41.799742, "lng": 20.909739, "zoom": 10 },

  "Veles2" : { "name" : "Велес 2", "lat": 41.7058, "lng": 21.7653, "zoom": 12 },
  "Kocani" : { "name" : "Кочани", "lat": 41.9139, "lng": 22.4158, "zoom": 10 },
  "Kavadarci" : { "name" : "Кавадарци", "lat": 41.4406, "lng": 22.0072, "zoom": 10 },
  "Kumanovo" : { "name" : "Куманово", "lat": 42.1356, "lng": 21.7147, "zoom": 10 },
  "Strumica" : { "name" : "Струмица", "lat": 41.439137, "lng": 22.643160, "zoom": 10 },
  
  "SkopjeRegion" : { "name" : "Агломерација Скопски pегион" },
  "WesternRegion" : { "name" : "Западна зона" },
  "EasternRegion" : { "name" : "Источна зона" }
		
},

"levels" : [ "Многу Високо", "Високо", "Средно", "Ниско", "Многу Ниско", "Нема податоци", "Не се мери" ],

"graph" : {
  "hourlyTitle" : "Часовни концентрации за %s во %s",
  "eightHourlyTitle" : "Осумчасовен %s концентрации во %s",
  "dailyTitle" : "Дневни %s концентрации за %s",
  "limitValue" : "граница: %s %s",
  "maximumEightHourTooltip" : "Најмногу осум часа просек за %s<br/>%s %s %s на %s"
},

"table" : {
  "hourlyTitle" : "Часовни концентрации за (%s)",
  "eightHourlyTitle" : "Осумчасовен %s концентрации (%s)",
  "dailyTitle" : "Дневни %s концентрации (%s)"
},

"map" : {
  "wholeMacedonia" : "Република Македонија",
  "worstPollutant" : "Загадувачка супстанца со највисока концентрација"
},

"weekDays": [
  'Пон',
  'Вто',
  'Сре',
  'Чет',
  'Пет',
  'Саб',
  'Нед'
],

"shortMonths": [
 'Јан',
 'Фев',
 'Мар',
 'Апр',
 'Мај',
 'Јун',
 'Јул',
 'Авг',
 'Сеп',
 'Окт',
 'Ное',
 'Дек'
],

"months": [
 'Јануари',
 'Февруари',
 'Март',
 'Април',
 'Мај',
 'Јуни',
 'Јули',
 'Август',
 'Септември',
 'Октомври',
 'Ноември',
 'Декември'
]

}