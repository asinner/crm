(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('UsersCtrl', [ '$scope', '$http', 'User', '$location', '$window', function($scope, $http, User, $location, $window) {

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
					$window.location.href = '/start';
				},
				function(response) {
					// User did not save
				}
			);
		};
				
	}]);
	
})()
