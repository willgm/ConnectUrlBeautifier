Connect Url Beautifier
=====

> A Node Connect middleware for beautiful URLs

```js
var app = connect()
app.use(urlBeautifier())
http.createServer(app).listen(3000)
```

## API

#### options.basePath

Type: `String`
Default: `/public`

The base path to check requested file existence

#### options.extension

Type: `String`
Default: `html`

The file extension to use

#### options.notFoundPage

Type: `String`
Default: `/404.html`

Optional custom not found page
