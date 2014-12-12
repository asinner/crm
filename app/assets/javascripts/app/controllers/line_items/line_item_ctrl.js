'use strict';

(function() {
	
	var app = angular.module('crmApp');
	
	app.controller('LineItemCtrl', ['$scope', '$rootScope', '$timeout', 'Session', 'LineItem', 'Current', 'EVENTS', function($scope, $rootScope, $timeout, Session, LineItem, Current, EVENTS) {
		
		$scope.show = {
			newForm: false,
			editForm: false
		};
		
		$scope.activeTab = 'revenue';
		
		$scope.currentLineItem = {
			name: '',
			description: '',
			role: '',
			amount: '',
			qty: ''
		}
		
		$scope.$on(EVENTS.lightbox.close, function(event, data) {
			$scope.resetForm();
			$scope.hideForms();
			$scope.resetCurrentLineItem();
		});

		$scope.$on(EVENTS.lineItem.newForm.show, function(event, data) {
			$scope.currentLineItem.role = data;
			$scope.show.newForm = true;
		});
		
		$scope.$on(EVENTS.lineItem.editForm.show, function(event, data) {
			$scope.show.editForm = true;
			$scope.currentLineItem = data;
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
			if ($scope.show.newForm) {
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
			lineItem.token = Session.token;
			lineItem.estimate_id = Current.getEvent().estimate.id;
			lineItem.$save().then(
				function(response) {
					$scope.close();
					$rootScope.$broadcast(EVENTS.lineItem.created, response.line_item);
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