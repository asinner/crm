(function() {
	
	var app = angular.module('crmApp');
	
	app.filter('roleFilter', function() {
		
		return function(leads, role) {
			
			if (role == 'report') return leads;
			
			var filtered = [];
			
			angular.forEach(leads, function(lead) {
				if (lead.role == role) filtered.push(lead);
			});
			
			return filtered;
		
		}
		
	});
	
})();