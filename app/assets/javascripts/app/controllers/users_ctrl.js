'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('UsersCtrl', [ '$scope', '$http', 'User', '$location', '$window', 'AuthService', function($scope, $http, User, $location, $window, AuthService) {

		$scope.currentUser = {
			name: '',
			email: '',
			password: ''
		};
		
		$scope.findByUnique = function(email) {
			return $http({
				method: 'GET',
				url: '/api/users/emails',
				params: { email: email }
			});
		};

		$scope.create = function() {
			var user = new User($scope.currentUser);
			user.$save().then(
				function(response) {			
					AuthService.login({
						email: $scope.currentUser.email,
						password: $scope.currentUser.password
					}).then(
						function() {
							$location.path('/start');
						},
						function() {
							console.log('There was an error logging in');
						}
					)
				},
				function(response) {
					// User did not save
				}
			);
		};
				
	}]);
	
})()
