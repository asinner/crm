(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('EVENTS', {
		
		lead: {
			show: 'showLead',
			created: 'leadCreated',
			new: 'newLead'
		},
		
		current: {
			event: {
				changed: 'currentEventChanged'
			}
		},
		
		event: {
			created: 'eventCreated',
			edit: 'editEvent',
			new: 'newEvent'
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
			view: {
				information: "viewLeadInformationTab",
				notes: "viewLeadNotesTab",
				estimate: "viewLeadEstimateTab",
				timeline: "viewLeadTimelineTab",
				files: "viewLeadFilesTab"
			}
		},
		
		estimate: {
			viewTab: 'viewEstimateTab'
		},
		
		address: {
			edit: 'editAddress'
		}
		
	});
	
})();