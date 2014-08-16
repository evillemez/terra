gulp = require 'gulp'
connect = require 'gulp-connect'
sourcemaps = require 'gulp-sourcemaps'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
gutil = require 'gulp-util'

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
  gulp.src 'src/*.jade'
    .pipe jade().on 'error', gutil.log
    .pipe gulp.dest('build/')
    .pipe connect.reload()
    .on 'error', gutil.log

gulp.task 'copy', ->
  gulp.src([
    'node_modules/pixi.js/bin/pixi.js'
  ])
  .pipe gulp.dest('build/vendor/')

gulp.task 'server', ['jade','coffee', 'copy'], ->
  connect.server {
    root: 'build/'
    port: 8111
    livereload: true
  }

gulp.task 'watch', ['server'], ->
  gulp.watch ['src/**/*.coffee'], ['coffee']
  gulp.watch ['src/**/*.jade'], ['jade']
    

gulp.task 'default', ['server']
