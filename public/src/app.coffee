# angular.module 'ContactsApp', []
#     .run ($rootScope)->
#         $rootScope.message = 'Hello Angular!'
#         return

angular.module 'ContactsApp', ['ngRoute', 'ngResource']
    .config ($routeProvider, $locationProvider)->
        $routeProvider
            .when('/contacts', {
                controller: 'ListController'
                templateUrl: 'views/list.html'
            })
        $locationProvider.html5Mode(true)
        return
