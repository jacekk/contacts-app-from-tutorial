express = require 'express'
low = require 'lowdb'
bodyParser = require 'body-parser'
uuid = require 'uuid'

db = low('data.json')
router = express.Router()

router
    .use (req, res, next)->
        if not req.user
            req.user = { id: 1 }
        next()
        return
    .use bodyParser.json()
    .route '/contact'
        .get (req, res)->
            res.json(db('contacts').value())
            return
        .post (req, res)->
            contact = req.body
            contact.id = uuid()
            db('contacts').push(contact)
            res.json(db('contacts').value())
            return

router
    .param 'hash', (req, res, next)->
        req.dbQuery = {
            id: req.params.hash
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
