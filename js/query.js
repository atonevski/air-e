// Generated by CoffeeScript 2.3.2
// query.coffee:

// query and view measurements for period, parameter, station/region

var URL, http, levels, toYMDHM, vue;

http = require('http');

URL = "http://air.moepp.gov.mk/graphs/site/pages/MakeGraph.php";

levels = {
  CO: {
    good: [0, 1],
    moderate: [1, 2],
    sensitive: [2, 9],
    unhealthy: [9, 17],
    veryUnhealthy: [17, 34],
    hazardous: [34, 100]
  },
  NO2: {
    good: [0, 40],
    moderate: [40, 80],
    sensitive: [80, 180],
    unhealthy: [180, 280],
    veryUnhealthy: [280, 400],
    hazardous: [400, 1000]
  },
  O3: {
    good: [0, 50],
    moderate: [50, 100],
    sensitive: [100, 168],
    unhealthy: [168, 208],
    veryUnhealthy: [208, 748],
    hazardous: [748, 2000]
  },
  PM10: {
    good: [0, 50],
    moderate: [50, 100],
    sensitive: [100, 250],
    unhealthy: [250, 350],
    veryUnhealthy: [350, 430],
    hazardous: [430, 2000]
  },
  PM10D: {
    good: [0, 50],
    moderate: [50, 100],
    sensitive: [100, 250],
    unhealthy: [250, 350],
    veryUnhealthy: [350, 430],
    hazardous: [430, 2000]
  },
  PM25: {
    good: [0, 30],
    moderate: [30, 60],
    sensitive: [60, 90],
    unhealthy: [90, 120],
    veryUnhealthy: [120, 250],
    hazardous: [250, 2000]
  },
  SO2: {
    good: [0, 40],
    moderate: [40, 80],
    sensitive: [80, 380],
    unhealthy: [380, 800],
    veryUnhealthy: [800, 1600],
    hazardous: [1600, 5000]
  }
};

//     params = {
//       "station"   => station,
//       "parameter" => parameter,
//       "beginDate" => begin_date.to_s(YMD),
//       "beginTime" => "00:00", # always
//       "endDate"   => end_date.to_s(YMD),
//       "endTime"   => sprintf("%02d:00", Time.now.hour), # when params passed check this
//       "i"         => Time.now.epoch,
//       "language"  => "mk"
//     }
//     params["endTime"] = "23:00" if end_date.to_s(YMD) < Time.now.to_s(YMD)

//     # puts params.to_json
//     url = URL +
//       "?parameter=#{ params["parameter"] }" +
//       "&station=#{ params["station"] }" +
//       "&beginDate=#{ params["beginDate"] }" +
//       "&beginTime=00:00" +
//       "&endDate=#{ params["endDate"] }" +
//       "&endTime=#{ params["endTime"]}" +
//       "&i=#{ params["i"] }" +
//       "&language=mk"
toYMDHM = function(d) {
  var dd;
  dd = (new Date(d - d.getTimezoneOffset() * 1000 * 60)).toISOString();
  return dd.slice(0, 10) + ' ' + dd.slice(11, 16);
};

vue = new Vue({
  el: '#app',
  data: {
    measurements: {},
    lang: {},
    fromDT: toYMDHM(new Date(new Date() - 24 * 60 * 60 * 1000)).slice(0, 14) + '00',
    toDT: toYMDHM(new Date()).slice(0, 14) + '00',
    parameter: 'PM10',
    parameters: [],
    station: 'SkopjeRegion',
    stations: []
  },
  methods: {
    getLangs: function() {
      var url;
      // mk
      url = 'http://air.moepp.gov.mk/graphs/site/js/lang.mk.js';
      http.get(url, (res) => {
        var body;
        body = '';
        res.setEncoding('utf-8');
        res.on('data', function(d) {
          return body += d;
        });
        return res.on('end', () => {
          eval(body);
          return this.lang.mk = lang;
        });
      });
      // en
      url = 'http://air.moepp.gov.mk/graphs/site/js/lang.en.js';
      return http.get(url, (res) => {
        var body;
        body = '';
        res.setEncoding('utf-8');
        res.on('data', function(d) {
          return body += d;
        });
        return res.on('end', () => {
          eval(body);
          this.lang.en = lang;
          this.parameters = Object.keys(lang.parameters);
          return this.stations = Object.keys(lang.stations);
        });
      });
    },
    paramLevel: function(p, v) { // parameter, value
      if (v == null) {
        return 'unknown';
      }
      switch (false) {
        case !((levels[p].good[0] <= v && v < levels[p].good[1])):
          return 'good';
        case !((levels[p].moderate[0] <= v && v < levels[p].moderate[1])):
          return 'moderate';
        case !((levels[p].sensitive[0] <= v && v < levels[p].sensitive[1])):
          return 'sensitive';
        case !((levels[p].unhealthy[0] <= v && v < levels[p].unhealthy[1])):
          return 'unhealthy';
        case !((levels[p].veryUnhealthy[0] <= v && v < levels[p].veryUnhealthy[1])):
          return 'very-unhealthy';
        case !((levels[p].hazardous[0] <= v && v < levels[p].hazardous[1])):
          return 'hazardous';
        default:
          return 'unknown';
      }
    },
    //     # puts params.to_json
    //     url = URL +
    //       "?parameter=#{ params["parameter"] }" +
    //       "&station=#{ params["station"] }" +
    //       "&beginDate=#{ params["beginDate"] }" +
    //       "&beginTime=00:00" +
    //       "&endDate=#{ params["endDate"] }" +
    //       "&endTime=#{ params["endTime"]}" +
    //       "&i=#{ params["i"] }" +
    //       "&language=mk"
    updateMeasurements: function() {
      var url;
      this.measurements = [];
      url = URL + '?' + `parameter=${this.parameter}&` + `station=${this.station}&` + `beginDate=${this.fromDT.slice(0, 10)}&` + `beginTime=${this.fromDT.slice(11, 16)}&` + `endDate=${this.toDT.slice(0, 10)}&` + `endTime=${this.toDT.slice(11, 16)}&` + `i=${(new Date).getTime()}&` + "language=mk";
      return http.get(url, (res) => {
        var body;
        body = '';
        res.setEncoding('utf-8');
        res.on('data', function(d) {
          return body += d;
        });
        res.on('error', function(e) {
          return console.log(`parameters error: ${e}`);
        });
        return res.on('end', () => {
          this.measurements = JSON.parse(body);
          console.log(this.measurements);
          return null;
        });
      });
    }
  },
  created: function() {
    return this.getLangs();
  }
});
