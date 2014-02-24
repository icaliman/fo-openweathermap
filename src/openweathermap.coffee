request = require 'request'
URL = require 'url'

# http://api.openweathermap.org/data/2.5/forecast/daily?lat=47&lon=29&units=metric&cnt=14
##
class Weather

  defaults: (@defaults) ->
    # nothing

#  getCurrentLatLng: (latitude, longitude, callback) ->
#    url = "http://api.openweathermap.org/data/2.5/weather?#{@_createQuery()}lat=#{encodeURIComponent latitude}&lon=#{encodeURIComponent longitude}"
#    @_getJSON url, (data) =>
#      callback new Weather.Current(data)
#
#  getCurrent: (city, callback) ->
#    url = "http://api.openweathermap.org/data/2.5/weather?#{@_createQuery()}q=#{encodeURIComponent city}"
#    @_getJSON url, (data) =>
#      callback new Weather.Current(data)

  getForecastLatLng: (latitude, longitude, callback) ->
    url = "http://api.openweathermap.org/data/2.5/forecast?mode=json&#{@_createQuery()}lat=#{encodeURIComponent latitude}&lon=#{encodeURIComponent longitude}"
    @_getJSON url, (err, data) =>
      return callback err if err
      callback null, new Weather.Forecast(data)

  getForecast: (city, callback) ->
    url = "http://api.openweathermap.org/data/2.5/forecast/city?mode=json&#{@_createQuery()}q=#{encodeURIComponent city}"
    @_getJSON url, (err, data) =>
      return callback err if err
      callback null, new Weather.Forecast(data)

  #
  # Private Methods
  #

  _getJSON: (url, callback) ->
    request.get url, (err, res, body) ->
      return callback err if err
      try
        json = JSON.parse body
      catch e
        return callback e
      callback null, json

  _createQuery: () ->
    query = ""
    for param, value of @defaults
      query += "#{param}=#{value}&"
    return query


#class Weather.Current
#
#  constructor: (data) ->
#    console.log "-------------- ", data

class Weather.Forecast

  constructor: (data) ->
    @list = []
    for x in data?.list
#      console.log "444444444444444444444444444444444444444=====", x
      @list.push
        date            : new Date(x.dt*1000)
        temperature     : x.main.temp
        humidity        : x.main.humidity
        pressure        : x.main.pressure
        wind_speed      : x.wind.speed
        wind_degrees    : x.wind.deg
        condition       : x.weather[0].main
        description     : x.weather[0].description
        sky             : x.clouds.all
#        feelslike       : parseInt(x.feelslike.metric)
#        wind_direction  : x.wind.deg
#        pop             : parseInt(x.pop)
#        qpf             : parseInt(x.qpf.metric||0)

module.exports = Weather