angular.module 'ContactsApp'
    .controller 'ListController', ($scope, Contact, $location)->
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
    .controller 'NewController', ($scope, Contact, $location)->
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
                $scope.contact.$save()
                $location.url '/contacts'
            return
        return
    .controller 'SingleController', ($scope, Contact, $location, $routeParams)->
        $scope.contact = Contact.get {
            id: $routeParams.id
        }
        $scope.remove = ()->
            $scope.contact.$delete()
            $location.url '/contacts'
            return
        return
