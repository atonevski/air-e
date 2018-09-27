# query.coffee:
#
# query and view measurements for period, parameter, station/region
#

http = require 'http'

URL = "http://air.moepp.gov.mk/graphs/site/pages/MakeGraph.php"

levels =
  CO:
    good:            [ 0,   1]
    moderate:        [ 1,   2]
    sensitive:       [ 2,   9]
    unhealthy:       [ 9,  17]
    veryUnhealthy:  [17,  34]
    hazardous:       [34, 100]

  NO2:
    good:            [  0,   40]
    moderate:        [ 40,   80]
    sensitive:       [ 80,  180]
    unhealthy:       [180,  280]
    veryUnhealthy:  [280,  400]
    hazardous:       [400, 1000]

  O3:
    good:            [  0,   50]
    moderate:        [ 50,  100]
    sensitive:       [100,  168]
    unhealthy:       [168,  208]
    veryUnhealthy:  [208,  748]
    hazardous:       [748, 2000]

  PM10:
    good:            [  0,   50]
    moderate:        [ 50,  100]
    sensitive:       [100,  250]
    unhealthy:       [250,  350]
    veryUnhealthy:  [350,  430]
    hazardous:       [430, 2000]

  PM10D:
    good:            [  0,   50]
    moderate:        [ 50,  100]
    sensitive:       [100,  250]
    unhealthy:       [250,  350]
    veryUnhealthy:  [350,  430]
    hazardous:       [430, 2000]

  PM25:
    good:            [  0,   30]
    moderate:        [ 30,   60]
    sensitive:       [ 60,   90]
    unhealthy:       [ 90,  120]
    veryUnhealthy:  [120,  250]
    hazardous:       [250, 2000]

  SO2:
    good:            [   0,   40]
    moderate:        [  40,   80]
    sensitive:       [  80,  380]
    unhealthy:       [ 380,  800]
    veryUnhealthy:  [ 800, 1600]
    hazardous:       [1600, 5000]

paramLevel = (p, v) -> # parameter, value
  switch
    when levels[p].good[0] <= v < levels[p].good[1]
      'good'
    when levels[p].moderate[0] <= v < levels[p].moderate[1]
      'moderate'
    when levels[p].sensitive[0] <= v < levels[p].sensitive[1]
      'sensitive'
    when levels[p].unhealthy[0] <= v < levels[p].unhealthy[1]
      'unhealthy'
    when levels[p].veryUnhealthy[0] <= v < levels[p].veryUnhealthy[1]
      'veryUnhealthy'
    when levels[p].hazardous[0] <= v < levels[p].hazardous[1]
      'hazardous'
    else
      'unknown'

#     params = {
#       "station"   => station,
#       "parameter" => parameter,
#       "beginDate" => begin_date.to_s(YMD),
#       "beginTime" => "00:00", # always
#       "endDate"   => end_date.to_s(YMD),
#       "endTime"   => sprintf("%02d:00", Time.now.hour), # when params passed check this
#       "i"         => Time.now.epoch,
#       "language"  => "mk"
#     }
#     params["endTime"] = "23:00" if end_date.to_s(YMD) < Time.now.to_s(YMD)
# 
#     # puts params.to_json
#     url = URL +
#       "?parameter=#{ params["parameter"] }" +
#       "&station=#{ params["station"] }" +
#       "&beginDate=#{ params["beginDate"] }" +
#       "&beginTime=00:00" +
#       "&endDate=#{ params["endDate"] }" +
#       "&endTime=#{ params["endTime"]}" +
#       "&i=#{ params["i"] }" +
#       "&language=mk"

toYMDHM = (d) ->
  dd = (new Date(d - d.getTimezoneOffset()*1000*60)).toISOString()
  dd[0..9] + ' ' + dd[11..15]

vue = new Vue
  el: '#app'

  data:
    measurements: { }
    lang: { }
    fromDT: toYMDHM(new Date(new Date() - 24*60*60*1000))[0..13] + '00'
    toDT: toYMDHM(new Date())[0..13] + '00'
    parameter: 'PM10'
    parameters: [ ]
    station: 'SkopjeRegion'
    stations: [ ]

  methods:
    getLangs: () ->
      # mk
      url = 'http://air.moepp.gov.mk/graphs/site/js/lang.mk.js'
      http.get url, (res) =>
        body = ''
        res.setEncoding 'utf-8'
        res.on 'data', (d) -> body += d
        res.on 'end', () =>
          eval body
          @lang.mk = lang
      # en
      url = 'http://air.moepp.gov.mk/graphs/site/js/lang.en.js'
      http.get url, (res) =>
        body = ''
        res.setEncoding 'utf-8'
        res.on 'data', (d) -> body += d
        res.on 'end', () =>
          eval body
          @lang.en = lang
          @parameters = Object.keys lang.parameters
          @stations = Object.keys lang.stations

#     # puts params.to_json
#     url = URL +
#       "?parameter=#{ params["parameter"] }" +
#       "&station=#{ params["station"] }" +
#       "&beginDate=#{ params["beginDate"] }" +
#       "&beginTime=00:00" +
#       "&endDate=#{ params["endDate"] }" +
#       "&endTime=#{ params["endTime"]}" +
#       "&i=#{ params["i"] }" +
#       "&language=mk"
    updateMeasurements: () ->
      @measurements = [ ]
      url = URL + '?' +
        "parameter=#{ @parameter }&" +
        "station=#{ @station }&" +
        "beginDate=#{ @fromDT[0..9] }&" +
        "beginTime=#{ @fromDT[11..15] }&" +
        "endDate=#{ @toDT[0..9] }&" +
        "endTime=#{ @toDT[11..15] }&" +
        "i=#{ (new Date).getTime() }&" +
        "language=mk"
      http.get url, (res) =>
        body = ''
        res.setEncoding 'utf-8'
        res.on 'data', (d) -> body += d
        res.on 'error', (e) -> console.log "parameters error: #{ e }"
        res.on 'end', () =>
          @measurements = JSON.parse body
          console.log @measurements
          null
      
  created: () ->
    @getLangs()
