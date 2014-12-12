(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('EVENTS', {
		
		lead: {
			show: 'showLead',
			created: 'leadCreated',
			newForm: {
				show: 'showNewLeadForm'
			}
		},
		
		event: {
			created: 'eventCreated'
		},
		
		lightbox: {
			close: 'closeLightbox',
			show: 'showLightbox'
		},
		
		lineItem: {
			list: 'listLineItems',
			created: 'lineItemCreated',
			destroyed: 'lineItemDestroyed',
			newForm: {
				show: 'showNewLineItemForm'
			},
			editForm: {
				show: 'showEditLineItemForm'
			}
		},
		
		note: {
			created: 'noteCreated'
		},
		
		navigation: {
			viewNotesTab: 'viewNotesTab',
			viewEstimateTab: 'viewEstimateTab'
		},
		
		estimate: {
			viewTab: 'viewEstimateTab'
		}
		
	});
	
})();