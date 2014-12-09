exports.config = {
	
	seleniumAddress: 'http://localhost:4444/wd/hub',
	
	specs: [
		'test/javascripts/**/*_test.js'
	],

	baseUrl: 'http://localhost:3000/'
	
}