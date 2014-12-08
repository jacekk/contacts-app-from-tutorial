angular.module 'ContactsApp'
    .controller 'ListController', ($scope, $rootScope, Contact, $location)->
        $rootScope.PAGE = 'all'
        $scope.contacts = Contact.query()
        $scope.fields = ['firstName', 'lastName']
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
