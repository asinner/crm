(function() {
	var app = angular.module('crmApp');
	
	app.controller('ConnectProductsToEstimateCtrl', ['$scope', 'LEAD_EVENTS', function($scope, LEAD_EVENTS) {
		
		$scope.$on(LEAD_EVENTS.viewEstimate, function(event) {
			
			
			
		});
		
	}]);
})();