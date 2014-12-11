'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('NewLineItemCtrl', ['$scope', '$rootScope', 'Session', 'LineItem', 'Current', 'EVENTS', function($scope, $rootScope, Session, LineItem, Current, EVENTS) {
		
		$scope.show = false;
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.newLineItem.$setPristine();
			$scope.newLineItem.$setUntouched();
			$scope.show = false;
		});
		
		$scope.$on(EVENTS.lineItem.newForm.show, function(event, data) {
			$scope.show = true;
		});
		
		$scope.showForm = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lineItem.newForm.show);
		};
		
		$scope.resetForm = function() {
			$scope.newLineItem.$setPristine();
			$scope.newLineItem.$setUntouched();
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
					$scope.resetForm();
					$rootScope.$broadcast(EVENTS.lineItem.created, response.line_item);
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
	}]);
	
})();