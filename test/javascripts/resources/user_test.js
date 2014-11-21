describe('User', function() {
	var mockUserResource, $httpBackend;
	
	beforeEach(angular.mock.module('crmApp'));
	
	beforeEach(function() {
		angular.mock.inject(function($injector) {
			$httpBackend = $injector.get('$httpBackend');
			mockUserResource = $injector.get('User');
		});
	});
	
	describe('getUser', function() {
		it('should call getUser with username', inject(function(User) {
			$httpBackend.expectGet('/api/users')
				.respond([{
					name: 'TEST'
				}]);
				
			var result = mockUserResource.getUser('test');
			
			$httpBackend.flush();
			
			expect(result[0].username).toEqual('test');
			
			
		}));
	});
});