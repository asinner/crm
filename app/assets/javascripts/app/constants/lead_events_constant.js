(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('LEAD_EVENTS', {
		created: 'createdLead',
		show: 'showLead',
		viewInfo: 'viewInfo',
		viewEstimate: 'viewEstimate',
		viewExpenseReport: 'viewExpenseReport',
		viewOrder: 'viewOrder'
	});
	
})()