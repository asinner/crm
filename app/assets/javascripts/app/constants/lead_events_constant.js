(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('LEAD_EVENTS', {
		created: 'created',
		viewLead: 'viewLead',
		viewInfo: 'viewInfo',
		viewNotes: 'viewNotes',
		viewEstimate: 'viewEstimate',
		viewExpenseReport: 'viewExpenseReport',
		viewOrder: 'viewOrder'
	});
	
})()