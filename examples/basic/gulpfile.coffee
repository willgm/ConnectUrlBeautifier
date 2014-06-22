gulp = require "gulp"
connect = require "gulp-connect"
plumber = require "gulp-plumber"
urlBeautifier = require "./../../bin/urlBeautifier"

gulp.task "default", ->
    connect.server
        root: "public"
        middleware: -> [
            urlBeautifier()
        ]
