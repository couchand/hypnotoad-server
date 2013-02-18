hypnotoad = require './hypnotoad.coffee'

[charm, interval] = hypnotoad process

charm.removeAllListeners('^C')
charm.on '^C', ->
  charm.background(0).write '\n'
  charm.reset()
  process.exit()
