// Generated by CoffeeScript 1.8.0
(function() {
  angular.module('ContactsApp').factory('Contact', function($resource) {
    return $resource('/api/contact/:id', {
      id: '@id'
    }, {
      update: {
        method: 'PUT'
      }
    });
  });

}).call(this);
