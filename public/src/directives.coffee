angular.module 'ContactsApp'
    .value 'FieldTypes', {
        text: ['Text', 'should be text']
        email: ['Email', 'should be an email address']
        number: ['Number', 'should be a number']
        date: ['Date', 'should be a date']
        datetime: ['Datetime', 'should be a datetime']
        time: ['Time', 'should be a time']
        month: ['Month', 'should be a month']
        week: ['Week', 'should be a week']
        url: ['URL', 'should be a URL']
        tel: ['Tel', 'should be a phone number']
        color: ['Color', 'should be a color']
    }
    .directive 'formField', ($timeout, FieldTypes)->
        {
            restrict: 'EA'
            templateUrl: 'views/form-field.html'
            replace: true
            scope: {
                record: '='
                field: '@'
                live: '@'
                required: '@'
            }
            link: ($scope, element, attr)->
                $scope.$on 'record:invalid', ()->
                    $scope[$scope.field].setDirty()
                    return
                $scope.types = FieldTypes
                $scope.remove = (field)->
                    delete $scope.record[field]
                    $scope.blurUpdate()
                    return
                $scope.blurUpdate = ()->
                    if $scope.live isnt 'false'
                        $scope.record.$update (updatedRecord)->
                            $scope.record = updatedRecord
                            return
                    return
                saveTimeout = null
                $scope.update = ()->
                    $timeout.cancel saveTimeout
                    saveTimeout = $timeout $scope.blurUpdate, 1000
                    return
                return
        }
