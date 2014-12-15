'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LineItemCtrl', ['$scope', '$rootScope', '$timeout', 'Session', 'LineItem', 'Current', 'EVENTS', 'FormCleaner', function($scope, $rootScope, $timeout, Session, LineItem, Current, EVENTS, FormCleaner) {
		
		$scope.model = {};
		
		$scope.show = { edit: false, new: false };
		
		$scope.activeTab = 'revenue';
		
		$scope.currentLineItem = {
			name: '',
			description: '',
			role: '',
			amount: '',
			qty: ''
		}
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.model = {};
			$scope.show = { edit: false, new: false };
			FormCleaner.clean($scope.lineItemForm);
		});

		$scope.$on(EVENTS.lineItem.newForm.show, function(event, data) {
			$scope.model.role = data;
			$scope.show.new = true;
		});
		
		$scope.$on(EVENTS.lineItem.editForm.show, function(event, data) {
			$scope.show.edit = true;
			$scope.model = data;
		});
				
		$scope.new = function(role) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lineItem.newForm.show, role);
		};
		
		$scope.edit = function(lineItem) {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.lineItem.editForm.show, lineItem);
		};
		
		$scope.save = function(lineItem) {
			if ($scope.show.new) {
				$scope.create(lineItem);
			} else {
				$scope.update(lineItem);
			}
		};
		
		$scope.destroy = function(lineItem) {	
			var lineItem = new LineItem(lineItem);
			lineItem.token = Session.token;
			lineItem.$delete().then(
				function(response) {
					$scope.close();
					$rootScope.$broadcast(EVENTS.lineItem.destroyed, lineItem);
				},
				function(response) {
					console.log(response);					
				}
			);
		};
		
		$scope.resetForm = function() {
			$scope.newLineItem.$setPristine();
			$scope.newLineItem.$setUntouched();
		};
		
		$scope.hideForms = function() {
			$scope.showDeleteConfirm = false;
			$scope.show.newForm = false;
			$scope.show.editForm = false;
		};
		
		$scope.resetCurrentLineItem = function() {
			$scope.currentLineItem = {
				name: '',
				amount: '',
				description: '',
				qty: ''
			}
		};
		
		$scope.create = function(lineItem) {
			var lineItem = new LineItem(lineItem);
			lineItem.estimate_id = Current.event.estimate.id;
			lineItem.$save(
				function(response) {
					$scope.close();
					$rootScope.$broadcast(EVENTS.lineItem.created, response);
				},
				function(response) {
					console.log(response);
				}
			)
		};
		
		$scope.update = function(lineItem) {
			var lineItem = new LineItem(lineItem);
			lineItem.token = Session.token;
			lineItem.$update().then(
				function(response) {
					$scope.close();
				},
				function(response) {
					console.log(response);					
				}
			)
		};
		
		$scope.setActiveTab = function(tab) {
			$scope.activeTab = tab;
			$rootScope.$broadcast(EVENTS.estimate.filterLineItems, tab);
		};
		
		
	}]);
	
})();