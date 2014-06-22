
assert = require "assert"
mockery = require "mockery"
urlBeautifier = require "./../bin/urlBeautifier"

describe 'Connect Url Beautifier', ->

    before -> mockery.enable warnOnReplace: false

    beforeEach -> mockery.registerMock 'fs', exists: (path, cb)-> cb true

    after -> mockery.disable()

    it 'should not add file extension if it is the url root', (done) ->
        req = url:'/'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/'
            done()

    it 'should not add file extension if there is already one', (done) ->
        req = url:'/test.css'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/test.css'
            done()

    it 'should not add file extension for a complex url path if there is already one', (done) ->
        req = url:'/path/to/test.css'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/path/to/test.css'
            done()

    it 'should add file extension for an url that has not', (done) ->
        req = url:'/test'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/test.html'
            done()

    it 'should add file extension for a complex url path that has not', (done) ->
        req = url:'/path/to/test'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/path/to/test.html'
            done()

    it 'should add file extension in an url that ends with /', (done) ->
        req = url:'/path/to/test/'
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/path/to/test.html'
            done()

    it 'should add file extension specially configured', (done) ->
        req = url:'/path/to/test/'
        urlBeautifier(extension:'cshtml') req, {}, ->
            assert.equal req.url, '/path/to/test.cshtml'
            done()

    it 'should show the not found page', (done) ->
        req = url:'/test/'
        mockery.registerMock 'fs', exists: (path, cb)-> cb false
        urlBeautifier() req, {}, ->
            assert.equal req.url, '/404.html'
            done()

    it 'should show the not found page specially configured', (done) ->
        req = url:'/test/'
        mockery.registerMock 'fs', exists: (path, cb)-> cb false
        urlBeautifier(notFoundPage:'/not-found.html') req, {}, ->
            assert.equal req.url, '/not-found.html'
            done()

    it 'should check existence of file requested by default at /public', (done) ->
        req = url:'/test/'
        mockery.registerMock 'fs', exists: (path, cb)->
            assert.equal path.lastIndexOf('/public/test.html'), (path.length-17)
            done()
        urlBeautifier() req, {}, ->

    it 'should check existence of file requested at the configured path', (done) ->
        req = url:'/test/'
        mockery.registerMock 'fs', exists: (path, cb)->
            assert.equal path.lastIndexOf('/base/test.html'), (path.length-15)
            done()
        urlBeautifier(basePath:'/base') req, {}, ->
