'use strict';

angular
  .module('manuableApp')
    .factory("currentUser", function($q, Restangular, $cookieStore) {
      var user,
          deferred = $q.defer(),
          remove = function(){
            user = undefined;
            deferred = $q.defer(),
            deferred.setUser = set;
            deferred.removeUser = remove;
          },
          set = function(u){
            user = u;
            Restangular.setDefaultHeaders({ 'Authorization': 'Token token=' + u.token });
            $cookieStore.put('currentUser', u);
            deferred.resolve(user);
          },
          get = function(){ return user; },
          update = function(u){
            _.extend(user, u);
            $cookieStore.put('currentUser', user);
          };

      return function(){
        deferred.promise.setUser = set;
        deferred.promise.removeUser = remove;
        deferred.promise.getUser = get;
        deferred.promise.updateUser = update;
        return deferred.promise;
      };
    });

