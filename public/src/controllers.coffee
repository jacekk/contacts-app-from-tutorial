angular.module 'ContactsApp'
    .controller 'ListController', ($scope, $rootScope, Contact, $location, options)->
        $rootScope.PAGE = 'all'
        $scope.contacts = Contact.query()
        $scope.fields = ['firstName', 'lastName'].concat options.displayedFields
        $scope.sort = (field)->
            $scope.sort.field = field
            $scope.sort.order = not $scope.sort.order
            return
        $scope.sort.field = 'firstName'
        $scope.sort.order = false
        $scope.show = (id)->
            $location.url "/contact/#{id}"
            return
        return
    .controller 'NewController', ($scope, $rootScope, Contact, $location, $timeout)->
        $rootScope.PAGE = 'new'
        $scope.contact = new Contact {
            firstName: ['', 'text']
            lastName: ['', 'text']
            email: ['', 'email']
            homePhone: ['', 'tel']
            cellPhone: ['', 'tel']
            birthday: ['', 'date']
            website: ['', 'url']
            address: ['', 'text']
        }
        $scope.save = ()->
            if $scope.newContact.$invalid
                $scope.$broadcast 'record:invalid'
            else
                $scope.contact.$save { responseType: 'json' }
                $timeout ()->
                    $location.url '/contacts'
                    return
                , 100
            return
        return
    .controller 'SingleController', ($scope, $rootScope, Contact, $location, $routeParams)->
        $rootScope.PAGE = 'single'
        $scope.contact = Contact.get {
            id: $routeParams.id
        }
        $scope.remove = ()->
            $scope.contact.$delete().then (data)->
                $location.url '/contacts'
                return
            return
        return
    .controller 'SettingsController', ($scope, $rootScope, options, Fields)->
        $rootScope.PAGE = 'settings'

        $scope.allFields = []
        $scope.fields = options.displayedFields

        Fields.headers().then (data)->
            $scope.allFields = data
            return

        $scope.toggle = (field)->
            index = options.displayedFields.indexOf(field)
            if index > -1
                options.displayedFields.splice index, 1
            else
                options.displayedFields.push field
            Fields.set options.displayedFields
            return
        return
