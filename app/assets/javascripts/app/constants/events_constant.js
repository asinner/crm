(function() {
	
	var app = angular.module('crmApp');
	
	app.constant('EVENTS', {
		
		lead: {
			show: 'showLead',
			created: 'leadCreated',
			newForm: {
				show: 'showNewLeadForm'
			},
			editForm: {
				show: 'showEditLeadForm'
			}
		},
		
		event: {
			created: 'eventCreated',
			edit: 'editEvent'
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
		}
		
	});
	
})();