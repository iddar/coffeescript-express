
# Module dependencies
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
assets = require 'connect-assets'

app = express()
#Create an instance of the object to be reused, for example: io = socket.listen(server)
server = http.createServer(app)

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

  #uncomment to enable the static files server
  #app.use express.static( path.join( __dirname, 'public' ) )

app.configure 'development', ->
  app.use express.errorHandler()
  app.use assets
    build: true
    compress: true
    buildDir: false

app.configure 'production', ->
  app.use assets
    build: true
    compress: true

app.get '/', routes.index

server.listen app.get('port'), ->
  console.log "Express server listening on port #{app.get 'port'}"
