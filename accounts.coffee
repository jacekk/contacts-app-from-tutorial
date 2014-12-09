express = require 'express'
bodyParser = require 'body-parser'
session = require 'express-session'
low = require 'lowdb'
crypto = require 'crypto'
uuid = require 'uuid'

hash = (password)->
    crypto
        .createHash 'sha256'
        .update password
        .digest 'hex'

db = low('database/accounts.json')
router = express.Router()

router
    .use bodyParser.urlencoded({ extended: true })
    .use bodyParser.json()
    .use session({
        secret: 'skjgfhsegf7287w3tcwebawc3c346tchw9XTw43ctgm98nxwf4'
        resave: true
        saveUninitialized: true
    })
    .get '/login', (req, res)->
        res.sendFile('public/login.html', { root: __dirname })
        return
    .post '/login', (req, res)->
        user = {
            username: req.body.username
            password: hash(req.body.password)
        }
        data = db('users').find(user).value()
        if data isnt undefined
            req.session.userId = data.id
            res.redirect '/'
        else
            res.redirect '/login'
        return
    .post '/register', (req, res)->
        user = {
            username: req.body.username
            password: hash(req.body.password)
            options: {}
        }
        data = db('users').find(user).value()
        if data is undefined
            user.id = uuid()
            db('users').push(user)
            req.session.userId = user.id
            res.redirect '/'
        else
            res.redirect '/login'
        return
    .get '/logout', (req, res)->
        req.session.userId = null
        res.redirect '/'
        return
    .use (req, res, next)->
        if req.session.userId
            data = db('users').find({ id: req.session.userId }).value()
            # this object cannot be a ref, because it is flushed - some weird behaviour
            req.user = {
                id: req.session.userId
                username: data.username
                options: data.options
            }
        next()
        return
    .get '/options/displayed-fields', (req, res)->
        if not req.user
            res.json []
        else
            res.json(req.user.options.displayedFields || [])
        return
    .post '/options/displayed-fields', (req, res)->
        req.user.options.displayedFields = req.body.fields
        db('users').find({ id: req.user.id }).assign({
            options: req.user.options
        })
        return


module.exports = router
