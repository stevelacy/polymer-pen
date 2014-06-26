path = require "path"
http = require "http"
gulp = require "gulp"
jade = require "gulp-jade"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"
reload = require "gulp-livereload"
express = require "express"

app = express()
app.use express.static path.resolve __dirname, "./public"

gulp.task "server", ->
  server = http.Server app
  server.listen 5000

gulp.task "jade", ->
  gulp.src "./src/**/*.jade"
  .pipe jade()
  .pipe gulp.dest "./public"
  .pipe reload()

gulp.task "coffee", ->
  gulp.src "./src/**/*.coffee"
  .pipe coffee()
  .pipe gulp.dest "./public"
  .pipe reload()

gulp.task "stylus", ->
  gulp.src "./src/**/*.styl"
  .pipe stylus()
  .pipe gulp.dest "./public"
  .pipe reload()

gulp.task "copy", ["copy:components"], ->
  gulp.src "./src/**/*.js"
  .pipe gulp.dest "./public"
  gulp.src "./src/**/*.png"
  .pipe gulp.dest "./public"
  gulp.src "./src/**/*.jpg"
  .pipe gulp.dest "./public"
  gulp.src "./src/**/*.json"
  .pipe gulp.dest "./public"
  gulp.src "./src/**/*.html"
  .pipe gulp.dest "./public"
  gulp.src "./src/**/*.css"
  .pipe gulp.dest "./public"

gulp.task "copy:components", ->
  gulp.src "src/components/**/*"
  .pipe gulp.dest "./public/components"

gulp.task "watch", ->
  gulp.watch "./src/**/*.jade", ["jade"]
  gulp.watch "./src/**/*.coffee", ["coffee"]
  gulp.watch "./src/**/*.styl", ["stylus"]
  gulp.watch ["!./src/**/*.styl", "!./src/**/*.jade", "!./src/**/*.coffee"], ["copy"]
  gulp.watch "./src/components/**/*", ["copy:components"]

gulp.task "default", ["jade", "stylus", "coffee", "watch", "copy", "server"]
