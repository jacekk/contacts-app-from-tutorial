angular.module 'ContactsApp', ['ngRoute', 'ngResource', 'ngMessages']
    .config ($routeProvider, $locationProvider)->
        $routeProvider
            .when '/contacts', {
                controller: 'ListController'
                templateUrl: 'views/list.html'
            }
            .when '/contact/new', {
                controller: 'NewController'
                templateUrl: 'views/new.html'
            }
            .when '/contact/:id', {
                controller: 'SingleController'
                templateUrl: 'views/single.html'
            }
            .when '/settings', {
                controller: 'SettingsController'
                templateUrl: 'views/settings.html'
            }
            .otherwise {
                redirectTo: '/contacts'
            }
        $locationProvider.html5Mode(true)
        return
    .value 'options', {}
    .run (options, Fields)->
        Fields.get().then (res)->
            options.displayedFields = res.data
            return
        return
