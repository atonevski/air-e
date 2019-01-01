# skp-sensors.coffee:
# - list all sonsors from sk pulse
#

https = require 'https'

CITY = 'skopje'

mapVisible = no

toggleMap = () ->
  mapVisible = not mapVisible
  el = document.getElementById 'map-id'
  if mapVisible
    el.style.display = 'block'
  else
    el.style.display = 'none'

vue = new Vue
  el: '#app'

  data:
    parameter: "pm10"

    center:
      lat: 41.99249998
      lng: 21.42361109

    map: null

    sensors: []
    sensorType:
      "0": 'MOEPP measurement station'
      "1": 'SkopjePulse LoRaWAN based sensor, version 1'
      "2": 'SkopjePulse WiFi based sensor, version 1'
      "3": 'pulse.eco WiFi based sensor, version 2'

    statusDesc:
      "ACTIVE": 'The sensor is up and running properly'
      "INACTIVE": 'The sensor is registered but turned off and ignored'
      "NOT_CLAIMED": 'The sensor is registered, but so far not bound to an owner'
      "BANNED": 'The sensor is manually removed from evidence in order to keep data sanity'

    valueType: ['pm10', 'pm25', 'temperature', 'humidity', 'noise']

  methods:
    toDtm: (d) ->
      throw "#{ d } is not Date()" unless d instanceof Date
      dd = (new Date(d - d.getTimezoneOffset()*1000*60))
      ymd= dd.toISOString()[0..9]
      re = /(\d\d:\d\d:\d\d) GMT([-+]\d+)/gm
      s = re.exec d.toString()
      "#{ ymd }T#{ s[1] }#{ s[2][0..2] }:#{ s[2][3..4] }"
    
    prepareMap: () ->
      @map = L.map 'map-id'
              .setView [@center.lat, @center.lng], 12

      L.tileLayer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { }
      # L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png', {}
      .addTo @map

    retrieveSensors: () ->
      t = new Date()
      f = new Date(t - 1*60*60*1000)
      # id = 1001
      id = "7c497bfd-36b6-4eed-9172-37fd70f17c48"
      url = "https://#{ CITY }.pulse.eco/rest/dataRaw?sensorId=#{ id }&type=#{ @parameter }&from=#{ encodeURIComponent(@toDtm f) }&to=#{ encodeURIComponent(@toDtm t) }"
      console.log url
      https.get url, (res) =>
        body = ''
        res.on 'data', (d) -> body += d
        res.on 'error', (e) -> console.log "raw data error: #{ e }"
        res.on 'end', () =>
          console.log body

  
    addSensorMarkers: () ->
      for s in @sensors
        [lat, lng] = s.position.split(',').map (x) -> parseFloat x
        marker = L.marker [lat, lng]
          .addTo @map
          .bindPopup """
            <table class='table-smaller-font'>
              <tbody>
              <tr>
                <th class='right'>Id</th>
                <td class='with-padding'>#{ s.sensorId }</td>
              </tr>
              <tr>
                <th class='right'>Sensor</th>
                <td class='with-padding'>#{ s.description }</td>
              </tr>
              <tr>
                <th class='right'>Position</th>
                <td class='with-padding'>#{ s.position }</td>
              </tr>
              <tr>
                <th class='right'>Type</th>
                <td class='with-padding'>#{ @sensorType[s.type] }</td>
              </tr>
              <tr>
                <th class='right'>Status</th>
                <td class='with-padding'>#{ s.status }</td>
              </tr>
              </tbody>
            </table>
          """
          .on 'click', (e) => this.openPopup

    getSensors: () ->
      url = "https://#{ CITY }.pulse.eco/rest/sensor"
      https.get url, (res) =>
        body = ''
        res.on 'data', (d) -> body += d
        res.on 'end', () =>
          @sensors = JSON.parse body
          @addSensorMarkers()

  created: () ->
    @retrieveSensors()
    @prepareMap()
    @getSensors()
