(function() {
	var app = angular.module('crmApp');
	
	app.factory('AuthService', function($q, $http, $cookieStore, Session) {
		var authService = {};
		
		authService.login = function(credentials) {
			var deferred = $q.defer();
			
			$http.post('/api/tokens', credentials).then(
				function(response, status) {					
					Session.create(response.data.token);
					$cookieStore.put('token', response.data.token);
					$cookieStore.put('user', response.data.user);
					deferred.resolve(response.data.user);
				},
				function(response, status) {
					deferred.reject(response.data.msg);	
				}
			);
			
			return deferred.promise;
		};
		
		authService.restoreCredentialsFromCookies = function() {
			var deferred = $q.defer();
			var token = $cookieStore.get('token');
			var user = $cookieStore.get('user');
			if (token && user) {
				Session.create(token);
				deferred.resolve(user);
			}
			
			return deferred.promise;
		};
		
		return authService;
		
	});
	
})()