(function() {
	
	var app = angular.module('crmApp');
	
	app.service('Current', function() {
		
		this.setEvent = function(eventt) {
			this.eventt = eventt;
		};
		
		this.getEvent = function() {
			return this.eventt;
		};
		
		this.setLead = function(lead) {
			this.lead = lead;
		};
		
		this.getLead = function() {
			return this.lead;
		};
		
	});
	
})();