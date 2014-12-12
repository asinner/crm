'use strict';

(function() {
	var app = angular.module('crmApp');
	
	app.controller('TokensCtrl', ['$scope', 'AuthService', '$location', function($scope, AuthService, $location) {
		
		$scope.error = '';
		
		$scope.credentials = {
			email: '',
			password: ''
		};
		
		$scope.create = function() {
			AuthService.login($scope.credentials).then(
				function(user) {
					$scope.error = '';
					$location.path('/dashboard');
					//$rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
					//$location.path('/dashboard');
					//$scope.setCurrentUser(user);
				},
				function(error) {
					$scope.error = error;
					//$rootScope.$broadcast(AUTH_EVENTS.loginFailed, error);
				}
			);
		};
		
	}]);
})()