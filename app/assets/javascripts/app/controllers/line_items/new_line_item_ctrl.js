'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('NewLineItemCtrl', ['$scope', '$rootScope', 'Session', 'LineItem', 'Current', function($scope, $rootScope, Session, LineItem, Current) {
		
		$scope.show = false;
		
		// Listeners
		$scope.$on(LIGHTBOX_EVENTS.close, function(event, data) {
			$scope.newLineItem.$setPristine();
			$scope.newLineItem.$setUntouched();
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
			lineItem.estimate_id = Current.getEvent().estimate.id;
			lineItem.$save().then(
				function(response) {
					$scope.currentLineItem = {
						name: '',
						amount: '',
						qty: '',
						description: ''
					};
					
					$rootScope.$broadcast(LINE_ITEM_EVENTS.created, response.line_item);
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
	}]);
	
})();