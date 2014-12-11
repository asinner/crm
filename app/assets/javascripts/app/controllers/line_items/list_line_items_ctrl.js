(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLineItemsCtrl', ['$scope', 'LineItem', 'Session', 'Current', function($scope, LineItem, Session, Current) {
		
		// Listeners
		$scope.$on(LINE_ITEM_EVENTS.showLineItems, function(event, data) {
			$scope.getLineItems(Current.getEvent().estimate);
		});
		
		$scope.$on(LINE_ITEM_EVENTS.created, function(event, data) {
			$scope.lineItems = $scope.lineItems.concat(data);
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