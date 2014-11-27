exports.config = {
	
	seleniumAddress: 'http://localhost:4444/wd/hub',
	
	specs: [
		'test/javascripts/features/user_can_sign_up_test.js'
	],

	baseUrl: 'http://localhost:3000/'
	
}