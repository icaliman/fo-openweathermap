assert = require 'assert'
chai = require('chai')
Forecast = require '../lib/openweathermap.js'

forecast = new Forecast

chai.should()

describe 'forecastjs', ->
  it 'test testing :)', (done) ->

    forecast.getForecast "Chisinau", (err, data) ->
      console.log "-=-=-=-=-=-=-=-=-=-=-=", data

      done(err)
