[Connect](https://github.com/senchalabs/connect) Url Beautifier
=====

> A Node Connect middleware for beautiful URLs

## Install

```
npm install url-beautifier --save
```

## Usage

```js
var connect = require('connect')
var urlBeautifier = require('url-beautifier')
var http = require('http')

var options = {}
var app = connect()
app.use(urlBeautifier(options))
http.createServer(app).listen(3000)
```

## API

#### options.extension

Type: `String`
Default: `html`

The file extension to complete

#### options.notFoundPage

Type: `String`
Default: `/404.html`

Custom not found page (optional)

#### options.basePath

Type: `String`
Default: `/public`

The base path to check file existence
