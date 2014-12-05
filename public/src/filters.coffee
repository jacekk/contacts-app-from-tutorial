angular.module 'ContactsApp'
    .filter 'labelCase', ()->
        # firstName --> First Name
        (input)->
            input = input.replace /([A-Z])/g, ' $1'
            input[0].toUpperCase() + input.slice(1)
    .filter 'camelCase', ()->
        # First Name --> firstName
        (input)->
            input.toLowerCase().replace /\ (\w)/g, (match, letter)->
                letter.toUpperCase()
    .filter 'keyFilter', ()->
        (obj, query)->
            result = {}
            angular.forEach obj, (val, key)->
                if key isnt query
                    result[key] = val
                return
            result
