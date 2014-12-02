express = require 'express'
low = require 'lowdb'
bodyParser = require 'body-parser'

db = low('data.json')
router = express.Router()

router
    .use (req, res, next)->
        if not req.user
            req.user = { id: 1 }
        next()
        return
    .use bodyParser.json()
    .route '/contacts'
        .get (req, res)->
            console.log 'find 1'
            # db('contacts').find { userId: parseInt(req.user.id, 10) }, (err, data)->
            #     res.json(data)
            #     return
            return
        .post (req, res)->
            contact = req.body
            contact.userId = req.user.id
            console.log 'insert 1'
            # db.insert contact, (err, data)->
            #     res.json(data)
            #     return
            return

router
    .param 'id', (req, res, next)->
        req.dbQuery = { id: parseInt(req.params.id, 10) }
        return
    .route '/contact/:id'
        .get (req, res)->
            gb.findOne req.dbQuery, (err, data)->
                res.json(data)
                return
            return
        .put (req, res)->
            contact = req.body
            delete contact.$promise
            delete contact.$resolved
            console.log 'update 1'
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
