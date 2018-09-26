# links:
# http://air.moepp.gov.mk/newmap.js
# http://air.moepp.gov.mk/graphs/site/js/draw.js
#
# elctron blue: #47848fed
#

http = require 'http'

notifyOnlineStatus = (e) ->
  new Notification 'Online status', 
        body: if navigator.onLine then 'You are online!' else 'You are offline now!'
        icon: if navigator.onLine then '../img/net-on.png' else '../img/net-off.png'
  console.log 'online/offline status changed!'


# addEventListener 'load', notifyOnlineStatus, false
addEventListener 'offline', notifyOnlineStatus, false
addEventListener 'online', notifyOnlineStatus, false

vue = new Vue
  el: '#app'

  data:
    lang: { }
    parameter: 'PM10'
    parameters: []
    map: null
    markerIcons: []
    markers: []

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

    prepareMap: () ->
      @map = L.map 'map-id'
              .setView [41.58, 21.8], 8

      L.tileLayer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {}
      .addTo @map

      @markerIcons = [
        L.icon({
          iconUrl: '../css/images/marker-icon-lgray.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
        ,
        L.icon({
          iconUrl: '../css/images/marker-icon-green.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
        ,
        L.icon({
          iconUrl: '../css/images/marker-icon-yellow.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
        ,
        L.icon({
          iconUrl: '../css/images/marker-icon-orange.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
        ,
        L.icon({
          iconUrl: '../css/images/marker-icon-red.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
        ,
        L.icon({
          iconUrl: '../css/images/marker-icon-violet.png'
          shadowUrl: '../css/images/marker-shadow.png'
          iconSize: [25, 41]
          shadowSize: [41, 41]
          iconAnchor: [12, 41]
          popupAnchor: [0, -43]})
      ]
      return null

    createMarkers: () ->
      for station, data of @data
        do (station, data) =>
          url = "http://air.moepp.gov.mk/fetchdata.php?" +
                "st=#{ station }&" +
                "begin=#{ data.time[-8..-1] }&" +
                "end=#{ data.time[-8..-1] }&" +
                "parameter=#{ data.parameter }"
          http.get url, (res) =>
            body = ''
            res.setEncoding 'utf-8'
            res.on 'data', (d) => body += d
            res.on 'end', () =>
              status = parseInt data.status
              st = @lang.mk.stations[station]
              h = JSON.parse body
              m = h[data.parameter][data.time[-8..-1]+"00"]
              marker = L.marker [st.lat, st.lng], { icon: @markerIcons[status] }
                .addTo @map
                .bindPopup "<b>#{ st.name }</b>, #{ data.time[-2..-1] }:00 <br />" +
                          "#{ @lang.mk.parameters[data.parameter][0].shortName } " +
                          "#{ if !m or m is -9999 then 'undefined' else m } " +
                          "#{ @lang.mk.parameters[data.parameter][0].unit } "
                .on 'click', (e) -> this.openPopup()
              @markers.push marker
      
    getInfo: () ->
      url = "http://air.moepp.gov.mk/fetch.php?parameter=#{ @parameter }"
      http.get url, (res) =>
        body = ''
        res.setEncoding 'utf-8'
        res.on 'data', (d) -> body += d
        res.on 'end', () =>
          @data = JSON.parse body
          console.log @data
          @createMarkers()

    onParameterChange: ()->
      for m in @markers
        m.remove()
      console.log "Parameter changed to: #{ @parameter }"
      @markers = []
      @getInfo()

  mounted: () ->
    notifyOnlineStatus()

  created: () ->
    @prepareMap()
    @getLangs()
    @getInfo()





#
# TODO:
# - add coloring for table data
# - about dialog
# - make first distribution
# - add git repo, and add several commits
# - get screenshots
# 
# DONE:
# - markers: red, green, yellow, orange, violet
# - resolved marker on-click listener
# - table data
# - offline/online trigger
