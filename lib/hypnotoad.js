// Generated by CoffeeScript 1.4.0
(function() {
  var charmer, fs, hypnotoad;

  fs = require('fs');

  charmer = require('charm');

  module.exports = hypnotoad = function(out) {
    var bg_img, charm, cols, draw, eye_frames, eye_imgs, frame, i, load, palettes, renderFrame, rows, toad_img;
    load = function(path) {
      return fs.readFileSync(path).toString().split('\n');
    };
    bg_img = load('resource/bgcolors.txt');
    toad_img = load('resource/toadcolors.txt');
    eye_imgs = load('resource/eyeframes.txt');
    eye_frames = [];
    i = 0;
    while (i < eye_imgs.length) {
      eye_frames.push(eye_imgs.slice(i, +(i + 6) + 1 || 9e9));
      i = i + 6;
    }
    charm = charmer(out);
    charm.reset();
    rows = bg_img.length;
    cols = bg_img[0].length;
    palettes = {
      bg: [72, 17, 23, 41, 25, 18],
      toad: [222, 178, 58, 154, 244, 198],
      eyes: [0, 196, 190, 154, 52]
    };
    draw = function(img, palette, xoff, yoff, r) {
      var c, color, old_color, x, y, _results;
      if (xoff == null) {
        xoff = 1;
      }
      if (yoff == null) {
        yoff = 1;
      }
      if (r == null) {
        r = rows;
      }
      old_color;

      y = 0;
      _results = [];
      while (y < r) {
        x = 0;
        while (x < cols) {
          color = img[y][x];
          if (color && color.match(/[0-9]/)) {
            c = palette[parseInt(color)];
            if (c !== old_color) {
              charm.background(c);
              old_color = c;
            }
            charm.write(' ');
          } else {
            charm.position(xoff + x, yoff + y);
          }
          ++x;
        }
        ++y;
        _results.push(charm.position(xoff, yoff + y));
      }
      return _results;
    };
    draw(bg_img, palettes.bg);
    draw(toad_img, palettes.toad);
    frame = 0;
    renderFrame = function() {
      var eyes;
      eyes = eye_frames[frame];
      draw(eyes, palettes.eyes, 44, 4, 6);
      frame = (frame + 1) % (eye_frames.length - 1);
      return charm.position(cols, rows);
    };
    return [charm, setInterval(renderFrame, 100)];
  };

}).call(this);