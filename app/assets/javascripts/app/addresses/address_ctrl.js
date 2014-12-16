(function() {
	
	'use strict';
	

	angular.module('crmApp').controller('AddressCtrl', ['$scope', '$rootScope', 'EVENTS', 'Address', 'FormCleaner', function($scope, $rootScope, EVENTS, Address, FormCleaner) {

		$scope.show = { edit: false, new: false };
		
		$scope.$on(EVENTS.address.edit, function(response, data) {
			$scope.show.edit = true;
			$scope.model = data;
		});
		
		$scope.$on(EVENTS.lightbox.close, function(response, data) {
			$scope.model = {};
			$scope.show = { edit: false, new: false};
			FormCleaner.clean($scope.addressForm);
		});
		
		$scope.edit = function(address) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.address.edit, $scope.current.event.address);
		};
		
		$scope.save = function(address) {
			if ($scope.show.new) {
				$scope.create(address);
			} else {
				$scope.update(address);
			}
		};
		
		$scope.update = function(address) {
			var address = new Address(address);
			address.$update(
				function(response) {
					$scope.close();
				},
				function(response) {
					
				}
			)
		};
		
	}]);

})();