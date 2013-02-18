# all glory to the hypnotoad

fs = require 'fs'

load = (path) ->
  fs.readFileSync(path).toString().split('\n')

bg_img = load 'resource/bgcolors.txt'
toad_img = load 'resource/toadcolors.txt'

charmer = require 'charm'
charm = charmer()

charm.pipe process.stdout
charm.reset()

rows = bg_img.length
cols = bg_img[0].length

palettes =
  bg: [72, 17, 23, 41, 25, 18]
  toad: [222, 142, 58, 144, 244, 198]

draw = (img, palette) ->
  old_color
  y = 0
  while y < rows
    x = 0
    while x < cols
      color = img[y][x]
      if color && color.match /[0-9]/
        c = palette[parseInt color]
        unless c is old_color
          charm.background(c)
          old_color = c
        charm.write ' '
      else
        charm.position 1+x, 1+y
      ++x
    ++y
    charm.position 1, 1+y

draw bg_img, palettes.bg
draw toad_img, palettes.toad
charm.background(0).write '\n'
