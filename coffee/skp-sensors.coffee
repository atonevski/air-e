# skp-sensors.coffee:
# - list all sonsors from sk pulse
#

https = require 'https'


mapVisible = no

toggleMap = () ->
  mapVisible = not mapVisible
  el = document.getElementById 'map-id'
  if mapVisible
    el.style.display = 'block'
  else
    el.style.display = 'none'

parameterChanged = (val) ->
  console.log "parameter changed to #{ val }"
  vue.parameter = val

vue = new Vue
  el: '#app'

  data:
    parameter: "pm10"

    CITY: 'skopje'
    UNAMEPW: (new Buffer("atonevski:pv1530kay")).toString 'base64'

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

#     retrieveSensors: () ->
#       to    = new Date()
#       from  = new Date(to - 1*60*60*1000)
#       opts =
#         hostname: "#{ @CITY }.pulse.eco"
#         path: "/rest/dataRaw?sensorId=#{ encodeURIComponent @sensors[1].sensorId }&" +
#               "type=#{ @parameter }&" +
#               "from=#{ encodeURIComponent @toDtm(from) }&" +
#               "to=#{ encodeURIComponent @toDtm(to) }"
#         port: 443
#         headers:
#           Authorization: 'Basic ' + @UNAMEPW
#       
#       console.log opts.headers.Authorize
#       console.log "https://#{ opts.hostname }#{ opts.path }"
# 
#       https.get opts, (res) =>
#         body = ''
#         res.on 'data', (d) -> body += d
#         res.on 'error', (e) -> console.log "retrieveSensors(): #{ e }"
#         res.on 'end', () =>
#           measurements = JSON.parse body
#           console.log measurements

    retrieveSensors: () ->
      for sen in @sensors
        do (sen) =>
          to    = new Date()
          from  = new Date(to - 1*60*60*1000)
          opts =
            hostname: "#{ @CITY }.pulse.eco"
            path: "/rest/dataRaw?sensorId=#{ encodeURIComponent sen.sensorId }&" +
                  "type=#{ @parameter }&" +
                  "from=#{ encodeURIComponent @toDtm(from) }&" +
                  "to=#{ encodeURIComponent @toDtm(to) }"
            port: 443
            headers:
              Authorization: 'Basic ' + @UNAMEPW
          
          https.get opts, (res) =>
            body = ''
            res.on 'data', (d) => body += d
            res.on 'error', (e) => console.log "retrieveSensors(): #{ e }"
            res.on 'end', () =>
              meas = JSON.parse body
              return if meas.length is 0
              lastm = meas[-1..][0]
              sen.parameter = lastm.type
              sen.value = lastm.value
              sen.stamp = lastm.stamp
              @addSensorMarker sen
  
    addSensorMarker: (s) -> # singular
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
            <tr>
              <th class='right'>Stamp</th>
              <td class='with-padding'>#{ s.stamp }</td>
            </tr>
            <tr>
              <th class='right'>Parameter</th>
              <td class='with-padding'>#{ s.parameter }</td>
            </tr>
            <tr>
              <th class='right'>Value</th>
              <td class='with-padding'>#{ s.value }</td>
            </tr>
            </tbody>
          </table>
        """
        .on 'click', (e) => this.openPopup

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
              <tr>
                <th class='right'>Stamp</th>
                <td class='with-padding'>#{ s.stamp }</td>
              </tr>
              <tr>
                <th class='right'>Parameter</th>
                <td class='with-padding'>#{ s.parameter }</td>
              </tr>
              <tr>
                <th class='right'>Value</th>
                <td class='with-padding'>#{ s.value }</td>
              </tr>
              </tbody>
            </table>
          """
          .on 'click', (e) => this.openPopup

    getSensors: () ->
      opts =
        hostname: "#{ @CITY }.pulse.eco"
        port: 443
        path:  '/rest/sensor'
        headers:
          Authorization: 'Basic ' + @UNAMEPW

      https.get opts, (res) =>
        body = ''
        res.on 'data', (d) -> body += d
        res.on 'error', (e) -> console.log "getSensors(): #{ e }"
        res.on 'end', () =>
          @sensors = JSON.parse body
          @retrieveSensors()
          # @addSensorMarkers()

  created: () ->
    @prepareMap()
    @getSensors()

# https://skopje.pulse.eco/rest/dataRaw?sensorId=7c497bfd-36b6-4eed-9172-37fd70f17c48&type=pm10&from=2019-01-03T06%3A12%3A33%2B01%3A00&to=2019-01-03T07%3A12%3A33%2B01%3A00

# skopje.pulse.eco
# name: sk-pulse
# email: atonevski@gmail.com
# username: atonevski
# password: pv1530kay
