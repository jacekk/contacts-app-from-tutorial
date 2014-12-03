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
