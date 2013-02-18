# all glory to the hypnotoad

fs = require 'fs'

load = (path) ->
  fs.readFileSync(path).toString().split('\n')

bg_img = load 'resource/bgcolors.txt'

charmer = require 'charm'
charm = charmer()

charm.pipe process.stdout
charm.reset()

rows = bg_img.length
cols = bg_img[0].length

palettes =
  bg: [72, 17, 23, 41, 25, 18]
  toad: [143, 142, 141, 144, 244, 39]

drawBackground = ->
  y = 0
  while y < rows
    x = 0
    while x < cols
      color = bg_img[y][x]
      if color && color.match /[0-9]/
        c = palettes.bg[parseInt color]
        charm.position(x,y).background(c).write ' '
      ++x
    ++y

drawBackground()
charm.background(0).write '\n'
