angular.module 'ContactsApp'
    .filter 'labelCase', ()->
        (input)->
            input = input.replace /([A-Z])/g, ' $1'
            input[0].toUpperCase() + input.slice(1)
