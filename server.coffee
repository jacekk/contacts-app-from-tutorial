express = require 'express'
api = require './api'

app = express()

app
    .use express.static('./public')
    .use '/api', api
    .get '*', (req, res)->
        res.sendFile('public/main.html', { root: __dirname })
        return
    .listen 3000
