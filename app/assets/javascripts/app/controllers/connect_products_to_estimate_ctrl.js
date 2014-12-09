(function() {
	var app = angular.module('crmApp');
	
	app.controller('ConnectProductsToEstimateCtrl', ['$scope', 'LEAD_EVENTS', 'Product', 'Session', function($scope, LEAD_EVENTS, Product, Session) {
		
		$scope.$on(LEAD_EVENTS.viewEstimate, function(event) {
			Product.query({
				token: Session.token
			}, function(response) {
				$scope.products = response.products;
			});
		});
		
	}]);
})();