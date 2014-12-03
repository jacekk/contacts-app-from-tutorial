angular.module 'ContactsApp'
    .filter 'labelCase', ()->
        (input)->
            input = input.replace /([A-Z])/g, ' $1'
            input[0].toUpperCase() + input.slice(1)
    .filter 'keyFilter', ()->
        (obj, query)->
            result = {}
            angular.forEach obj, (val, key)->
                if key isnt query
                    result[key] = val
                return
            result
