'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListProductsCtrl', ['$scope', 'EVENTS', 'Product', function($scope, EVENTS, Product) {
	
		$scope.products = [];
		
		$scope.$on(EVENTS.navigation.view.estimate, function(event, data) {
			$scope.list();
		});
		
		$scope.$on(EVENTS.lead.show, function(event, data) {
			if ($scope.activeTab == 'estimate') {
				$scope.list();
			}
		});
		
		$scope.list = function() {
			Product.query({}, function(response) {
				$scope.products = response.products;
			});
		};
			
	}]);
	
})();