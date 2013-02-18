http = require 'http'
hypnotoad = require './hypnotoad.coffee'

server = http.createServer (req, res) ->
  res.setHeader 'content-type', 'text/ansi'

  [charm, interval] = hypnotoad res

  req.connection.on 'end', ->
    clearInterval interval
    charm.end()

server.listen 8081
console.log 'listening on localhost:8081'
