(function() {
	'use strict';
	
	var app = angular.module('crmApp');
	
	app.controller('ListLineItemsCtrl', ['$scope', '$filter', 'LineItem', 'Session', 'Current', 'EVENTS', 'Deduplicate', function($scope, $filter, LineItem, Session, Current, EVENTS, Deduplicate) {
		
		$scope.role = 'revenue';		
		
		$scope.lineItems = [];
		
		$scope.$on(EVENTS.estimate.filterLineItems, function(event, data) {
			$scope.role = data;
		});
		
		$scope.$on(EVENTS.navigation.view.estimate, function(event, data) {
			$scope.list(Current.event.estimate);
		});
		
		$scope.$on(EVENTS.lead.show, function(event) {
			$scope.list(Current.getEvent().estimate);
		});
		
		$scope.$on(EVENTS.lineItem.created, function(event, data) {
			$scope.line_items = Deduplicate.updateOrAdd($scope.lineItems, data.line_items);
		});
				
		$scope.$on(EVENTS.lineItem.destroyed, function(event, data) {
			angular.forEach($scope.lineItems, function(key, value) {
				if (key.id == data.id) {
					$scope.lineItems.splice(value, 1);
				}
			});
		});		
		
		$scope.$on(EVENTS.current.event.changed, function(event, data) {
			if (Current.tab == 'estimate') {
				$scope.list(Current.event.estimate);
			}
		});
		
		$scope.list = function(estimate) {
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