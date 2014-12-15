'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ProductCtrl', ['$scope', '$rootScope', 'ProductToLineItem', 'LineItem', 'Current', 'EVENTS', function($scope, $rootScope, ProductToLineItem, LineItem, Current, EVENTS) {
		
		$scope.addToEstimate = function(product) {
			var lineItem = new LineItem(ProductToLineItem.create(product));
			lineItem.estimate_id = Current.event.estimate.id;
			lineItem.$save().then(
				function(response) {
					$rootScope.$broadcast(EVENTS.lineItem.created, response);
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
	}]);
	
})();