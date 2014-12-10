(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('NewLineItemCtrl', ['$scope', 'LIGHTBOX_EVENTS', '$rootScope', 'LINE_ITEM_EVENTS', 'Session', 'LineItem', function($scope, LIGHTBOX_EVENTS, $rootScope, LINE_ITEM_EVENTS, Session, LineItem) {
		
		$scope.show = false;
		
		// Listeners
		$scope.$on(LIGHTBOX_EVENTS.close, function(event, data) {
			$scope.show = false;
		});
		
		$scope.$on(LINE_ITEM_EVENTS.showForm, function(event, data) {
			$scope.show = true;
		});
		
		$scope.showForm = function() {
			$rootScope.$broadcast(LIGHTBOX_EVENTS.show);
			$rootScope.$broadcast(LINE_ITEM_EVENTS.showForm);
		};
		
		$scope.create = function(lineItem) {
			var lineItem = new LineItem(lineItem);
			lineItem.token = Session.token;
			lineItem.estimate_id = Session.currentEvent.estimate.id;
		};
		
	}]);
	
})();