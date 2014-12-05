(function() {
	var app = angular.module('crmApp');
	
	app.controller('ViewLeadCtrl', ['$scope', 'LEAD_EVENTS', function($scope, LEAD_EVENTS) {
		
		$scope.$on(LEAD_EVENTS.viewLead, function(event, data) {
			$scope.activeTab = 1;
		});
		
		$scope.setActiveTab = function(num) {
			$scope.activeTab = num;
		};	
		
	}]);
})()