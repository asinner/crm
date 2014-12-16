(function() {
	
	'use strict';
	
	angular.module('crmApp').service('S3Service', ['$http', function($http){
		
		var s3_service = {};
		
		s3_service.upload = function(data, file) {
			
			var formData = new FormData();
			
			angular.forEach(data.presigned_post, function(v, k) {
				formData.append(k, v);
			});
			formData.append('file', file);

			var request = $http.post(data.url, formData, {
				transformRequest: angular.identity,
				headers: { 'Content-Type': undefined }
			});
			
			return request;
			
		};
		
		
		return s3_service;
		
		
	}]);
	
})();