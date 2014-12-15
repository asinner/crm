(function() {
	
	'use strict';
	

	angular.module('crmApp').controller('AddressCtrl', ['$scope', function($scope) {

		$scope.show = { edit: false, new: false };
		
		$scope.edit = function(address) {
			console.log(address);
		};
		
	}]);

})();