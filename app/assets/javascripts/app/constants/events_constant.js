(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('EVENTS', {
		
		lead: {
			show: 'showLead',
			created: 'leadCreated'
		},
		
		event: {
			created: 'eventCreated'
		},
		
		lightbox: {
			close: 'closeLightbox',
			show: 'showLightbox'
		}
		
	});
	
})();