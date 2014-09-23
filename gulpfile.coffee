path = require 'path'
fs = require 'fs'
glob = require 'glob'
gulp = require 'gulp'
connect = require 'gulp-connect'
sourcemaps = require 'gulp-sourcemaps'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
gutil = require 'gulp-util'

VENDOR_SCRIPTS = [
  'node_modules/pixi.js/bin/pixi.js'
  'node_modules/voronoi/rhill-voronoi-core.js'
  'bower_components/threejs/build/three.js'
  'misc/orbit-controls.js'
  'misc/classical-noise.js'
  'misc/simplex-noise.js'
]

gulp.task 'coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe coffee({bare: true}).on 'error', gutil.log
    .pipe concat('scripts.js')
    .pipe sourcemaps.write()
    .pipe gulp.dest('build/')
    .pipe connect.reload()
    .on 'error', gutil.log

gulp.task 'jade', ->
  #assemble jade ops (shaders & scripts)
  ops = {
    shaders: {}
    vendorScripts: '/vendor/' + path.basename(script) for script in VENDOR_SCRIPTS
  }

  #get all shader code
  for file in glob.sync '**/*.glsl'
    ops.shaders[path.basename(file, '.glsl')] = fs.readFileSync file

  gulp.src 'src/*.jade'
    .pipe jade({locals: ops}).on 'error', gutil.log
    .pipe gulp.dest('build/')
    .pipe connect.reload()
    .on 'error', gutil.log

gulp.task 'copy', ->
  gulp.src(VENDOR_SCRIPTS).pipe gulp.dest('build/vendor/')

gulp.task 'server', ['jade', 'coffee', 'copy'], ->
  connect.server {
    root: 'build/'
    port: 8111
    livereload: true
  }

gulp.task 'watch', ['server'], ->
  gulp.watch ['src/**/*.coffee'], ['coffee']
  gulp.watch ['src/**/*.jade', 'src/**/*.glsl'], ['jade']
    

gulp.task 'default', ['server']
