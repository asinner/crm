'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListProductsCtrl', ['$scope', 'EVENTS', 'Product', function($scope, EVENTS, Product) {
	
		$scope.products = [];
		
		$scope.$on(EVENTS.navigation.viewEstimateTab, function(event, data) {
			$scope.getProductList();
		});
		
		$scope.getProductList = function() {
			Product.query({}, function(response) {
				$scope.products = response.products;
			});
		};
			
	}]);
	
})();