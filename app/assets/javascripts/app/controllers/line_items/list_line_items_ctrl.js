'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLineItemsCtrl', ['$scope', '$filter', 'LineItem', 'Session', 'Current', 'EVENTS', function($scope, $filter, LineItem, Session, Current, EVENTS) {
		
		$scope.role = 'revenue';
		
		$scope.anything = 'Andrew';
		
		$scope.lineItems = [];
		
		$scope.$on(EVENTS.estimate.filterLineItems, function(event, data) {
			$scope.role = data;
		});
		
		$scope.$on(EVENTS.navigation.viewEstimateTab, function(event, data) {
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
		
		$scope.total = function(lineItems) {
			var lineItems = $filter('roleFilter')($scope.lineItems, $scope.role);
			var total = 0;
			angular.forEach(lineItems, function(item) {
				if (item.role == 'expense') total = total - (item.amount * item.qty);
				if (item.role == 'revenue') total = total + (item.amount * item.qty);
			});
			return total;
		};
		
	}]);
	
})();