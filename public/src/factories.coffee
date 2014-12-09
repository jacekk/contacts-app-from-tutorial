angular.module 'ContactsApp'
    .factory 'Contact', ($resource)->
        $resource '/api/contact/:id', {
            id: '@id'
        }, {
            update: { method: 'PUT' }
        }
    .factory 'Fields', ($q, $http, Contact)->
        url = '/options/displayed-fields'
        ignore = ['firstName', 'lastName', 'id', 'userId']
        allFields = []
        deferred = $q.defer()

        contacts = Contact.query ()->
            contacts.forEach (c)->
                Object.keys(c).forEach (k)->
                    if allFields.indexOf(k) < 0 and ignore.indexOf(k) < 0
                        allFields.push(k)
                    return
                return
            deferred.resolve(allFields)
            return

        {
            get: ()->
                $http.get url
            set: (newFields)->
                $http.post url, { fields: newFields }
            headers: ()->
                deferred.promise
        }
