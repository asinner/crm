'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLineItemsCtrl', ['$scope', 'LineItem', 'Session', 'Current', 'EVENTS', function($scope, LineItem, Session, Current, EVENTS) {
		
		$scope.lineItems = [];
		
		$scope.$on(EVENTS.navigation.viewEstimate, function(event, data) {
			$scope.getLineItems(Current.getEvent().estimate);
		});
		
		$scope.$on(EVENTS.lineItem.created, function(event, data) {
			$scope.lineItems = $scope.lineItems.concat(data);
		});
		
		$scope.$on(EVENTS.lineItem.destroyed, function(event, data) {
			angular.forEach($scope.lineItems, function(key, value) {
				if (key.id == data.id) {
					$scope.lineItems.splice(value, 1);
				}
			});
		});
		
		$scope.getLineItems = function(estimate) {
			LineItem.query({
				estimate_id: estimate.id,
				token: Session.token
			}, function(response) {
				$scope.lineItems = response.line_items;
			});
		};
		
		$scope.total = function() {
			var total = 0;
			angular.forEach($scope.lineItems, function(item) {
				total = total + (item.amount * item.qty);
			});
			return total;
		};
		
	}]);
	
})();