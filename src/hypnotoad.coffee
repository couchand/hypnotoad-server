# all glory to the hypnotoad

fs = require 'fs'
charmer = require 'charm'

module.exports = hypnotoad = (out) ->
  load = (path) ->
    fs.readFileSync(path).toString().split('\n')

  bg_img = load 'resource/bgcolors.txt'
  toad_img = load 'resource/toadcolors.txt'

  eye_imgs = load 'resource/eyeframes.txt'
  eye_frames = []

  i = 0
  while i < eye_imgs.length
    eye_frames.push eye_imgs[i..i+6]
    i = i + 6

  charm = charmer out
  charm.reset()

  rows = bg_img.length
  cols = bg_img[0].length

  palettes =
    bg: [72, 17, 23, 41, 25, 18]
    toad: [222, 178, 58, 154, 244, 198]
    eyes: [0, 196, 190, 154, 52]

  draw = (img, palette, xoff=1, yoff=1, r=rows) ->
    old_color
    y = 0
    while y < r
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
          charm.position xoff+x, yoff+y
        ++x
      ++y
      charm.position xoff, yoff+y

  draw bg_img, palettes.bg
  draw toad_img, palettes.toad

  frame = 0
  renderFrame = ->
    eyes = eye_frames[frame]
    draw eyes, palettes.eyes, 41, 2, 6
    frame = (frame+1) % (eye_frames.length-1)
    charm.position cols, rows

  return [charm, setInterval renderFrame, 100]
