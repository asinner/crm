'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('ApplicationCtrl', ['$scope', '$location', '$cookieStore', 'AuthService', 'Current', function($scope, $location, $cookieStore, AuthService, Current) {
		
		$scope.current = Current;
		
		$scope.currentUser = null;
		
		AuthService.restoreCredentialsFromCookies().then(
			function(user) {
				$scope.setCurrentUser(user);
			}
		);
		
		$scope.setCurrentUser = function(user) {
			$scope.currentUser = user;
		};
			
	}]);
})()