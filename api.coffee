express = require 'express'
low = require 'lowdb'
bodyParser = require 'body-parser'
uuid = require 'uuid'

db = low('database/data.json')
router = express.Router()

router
    .use bodyParser.json()
    .use (req, res, next)->
        if not req.user
            res.json({ error: 'user not set' })
            return
        next()
        return
    .route '/contact'
        .get (req, res)->
            data = db('contacts')
                .where({ userId: req.user.id })
                .value()
            res.json(data)
            return
        .post (req, res)->
            contact = req.body
            contact.id = uuid()
            contact.userId = req.user.id
            db('contacts').push(contact)
            res.json({})
            return


router
    .param 'hash', (req, res, next)->
        if not req.user.id or not req.params.hash
            return
        req.dbQuery = {
            id: req.params.hash
            userId: req.user.id
        }
        next()
        return
    .route '/contact/:hash'
        .get (req, res)->
            found = db('contacts').find(req.dbQuery).value()
            res.json(found)
            return
        .put (req, res)->
            contact = req.body
            delete contact.$promise
            delete contact.$resolved
            db('contacts').find(req.dbQuery).assign(contact)
            res.json(contact)
            return
        .delete (req, res)->
            db('contacts').remove(req.dbQuery)
            res.json(null)
            return

module.exports = router
