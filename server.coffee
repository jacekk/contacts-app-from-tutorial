express = require 'express'
accounts = require './accounts'
api = require './api'

app = express()

app
    .use express.static('./public')
    .use accounts
    .use '/api', api
    .get '*', (req, res)->
        if not req.user
            res.redirect '/login'
        else
            res.sendFile('public/main.html', { root: __dirname })
        return
    .listen 3000
