(function() {
	
	'use strict';
	
	angular.module('crmApp').controller('UploadCtrl', ['$scope', '$rootScope', 'EVENTS', 'Upload', 'Current', 'S3Service', function($scope, $rootScope, EVENTS, Upload, Current, S3Service) {
		
		$scope.uploads = [];
				
		$scope.show = { new: false, edit: false }
		
		$scope.$on(EVENTS.upload.new, function(response, data) {
			$scope.show.new = true;
		});
		
		$scope.new = function() {
			$rootScope.$broadcast(EVENTS.lightbox.show);
			$rootScope.$broadcast(EVENTS.upload.new);
		};
		
		$scope.create = function(upload) {
			
			var fileInput = $('#upload-form form').find("input[type='file']");
			
			angular.forEach(fileInput[0].files, function(k, v) {;
				
				var upload = new Upload({
					name: k.name,
					size: k.size,
					mime_type: k.type,
					event_id: Current.event.id
				});
				
				// File has saved to the DB
				upload.$save().then(
					
					function(response) {
						
						// Create a new upload
						var upload = new Upload(response.upload);
						
						// Upload to S3
						S3Service.upload(response, k).then(

							function(response) {
								
					 	 		upload.$update({ uploaded: true });
					
								$scope.uploads.push(upload);
					
							},
							function(response) {
								
								// Bad upload from S3
							}
							
						);
					},
					function(response) {
						
						// Bad upload on validation
						console.log(response);
						
					}
				)
				
			});
			
		};
		
	}]);
	
})();
