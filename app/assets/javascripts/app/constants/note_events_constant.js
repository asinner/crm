(function() {
	var app = angular.module('crmApp');
	
	app.constant('NOTE_EVENTS', {
		created: 'createdNote',
		viewNotes: 'viewNotes'
	});
})()