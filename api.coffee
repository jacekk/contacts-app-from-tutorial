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
    .param 'id', (req, res, next)->
        req.dbQuery = { id: parseInt(req.params.id, 10) }
        return
    .route '/contact/:id'
        .get (req, res)->
            console.log 'get 1'
            # db.findOne req.dbQuery, (err, data)->
            #     res.json(data)
            #     return
            return
        .put (req, res)->
            contact = req.body
            delete contact.$promise
            delete contact.$resolved
            console.log 'put 1'
            # db.update req.dbQuery, contact, (err, data)->
            #     res.json(data[0])
            #     return
            return
        .delete (req, res)->
            console.log 'delete 1'
            # db.delete req.dbQuery, ->
            #     res.json(null)
            #     return
            return

module.exports = router
