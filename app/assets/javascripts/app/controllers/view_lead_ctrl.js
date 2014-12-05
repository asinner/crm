(function() {
	var app = angular.module('crmApp');
	
	app.controller('ViewLeadCtrl', ['$scope', 'LEAD_EVENTS', function($scope, LEAD_EVENTS) {
		
		$scope.$on(LEAD_EVENTS.viewLead, function(event, data) {
			$scope.setActiveTab(1);
			$scope.setCurrentLead(data);
		});
		
		$scope.setActiveTab = function(num) {
			$scope.activeTab = num;
		};
		
		$scope.setCurrentLead = function(lead) {
			$scope.currentLead = lead;
		};
		
	}]);
})()