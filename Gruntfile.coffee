module.exports = (grunt)->
	grunt.initConfig
		browserify:
			dev:
				files: "client/bundle.js": ["client/main.coffee"]
				options:
					debug: true
					transform: [
						"caching-coffeeify"
					]

		karma:
			unit:
				options:
					browsers: ["PhantomJS"]
					frameworks: ["jasmine"]
					singleRun: true
					files: [
							"bower_components/angular/angular.js"
							"bower_components/angular-mocks/angular-mocks.js"
							"client/bundle.js"
							"client/app/**/test.coffee"
						]

		mochaTest:
			server:
				options:
					reporter: 'spec'
				src: ["server/test/*coffee"]

		cucumberjs:
			Edith:
				files: src: ['test/behavior/users/edith']
				options:
					steps: 'test/behavior/steps'

		watch:
			all:
				files: [
					'test/**/*coffee'
					'server/**/*coffee'
					'client/**/*html'
					'client/**/*coffee'
					'client/**/*less'
				]
				tasks: ['default']

	grunt.npmTasks = [
		"grunt-cucumber"
		"grunt-karma"
		"grunt-browserify"
		"grunt-mocha-test"
		"grunt-contrib-watch"
	]

	grunt.loadNpmTasks npmTask for npmTask in grunt.npmTasks

	grunt.registerTask "build", [
		"browserify:dev"
	]

	grunt.registerTask "test", [
		"mochaTest:server"
		"karma:unit"
		"cucumberjs:Edith"
	]

	grunt.registerTask "default", [
		"build"
		"test"
	]
