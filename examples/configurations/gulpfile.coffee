gulp = require "gulp"
connect = require "gulp-connect"
plumber = require "gulp-plumber"
urlBeautifier = require "./../../bin/urlBeautifier"

gulp.task "default", ->
    connect.server
        root: "my-path"
        middleware: -> [
            urlBeautifier
                basePath: '/my-path'
                extension: 'htm'
                notFoundPage: '/not-found.htm'
        ]
