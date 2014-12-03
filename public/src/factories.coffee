angular.module 'ContactsApp'
    .factory 'Contact', ($resource)->
        $resource '/api/contact/:id', { id: '@id' }, {
            'update': { method: 'PUT' }
        }
