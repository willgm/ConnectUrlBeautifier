
module.exports = ({notFoundPage, extension, basePath} = {}) ->
    notFoundPage = "/404.html" unless notFoundPage
    extension = "html" unless extension
    basePath = "/public" unless basePath
    fs = require 'fs'

    (req, res, next) ->
        return next() if req.url is "/"
        req.url = req.url.slice(0,-1) if req.url.lastIndexOf("/") is (req.url.length-1)
        fileName = req.url.split("/").pop()
        req.url += ".#{extension}" if fileName and fileName.indexOf(".") is -1
        filePath = process.cwd() + basePath + req.url
        fs.exists filePath, (exists) ->
            req.url = notFoundPage unless exists
            next()
