(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('ListLineItemsCtrl', ['$scope', 'LINE_ITEM_EVENTS', 'LineItem', 'Session', function($scope, LINE_ITEM_EVENTS, LineItem, Session) {
		
		$scope.$on(LINE_ITEM_EVENTS.showLineItems, function(event, data) {
						
			$scope.getLineItems(data.selectedEvent.estimate);
			
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