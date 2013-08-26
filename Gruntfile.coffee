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
						"client/**/unit.coffee"
					]

		mochaTest:
			server:
				options:
					reporter: 'spec'
				src: ["server/test/*coffee"]

		shell:
			kill:
				command: "lsof -i TCP -P | grep 4444 | awk '{print $2}' | xargs -I{} kill {} >/dev/null  || exit 0"
			selenium:
				command: [
					"java -jar ./selenium/selenium-server-standalone-2.34.0.jar "
					"-Dwebdriver.chrome.driver=./selenium/chromedriver "
					">/dev/null"
				].join ' '
				options:
					async: true
					kill: true
			sleep:
				command:
					"sleep 1"

		cucumberjs:
			Edith:
				files: src: ['test/behavior/users/edith']
				options:
					steps: 'test/behavior/steps'

		watch:
			all:
				files: [
					'test/**/*coffee'
					'test/**/*feature'
					'server/**/*coffee'
					'client/**/*html'
					'client/**/*coffee'
					'client/**/*less'
				]
				tasks: ['default']

	grunt.npmTasks = [
		"grunt-cucumber"
		"grunt-karma"
		"grunt-shell-spawn"
		"grunt-browserify"
		"grunt-mocha-test"
		"grunt-contrib-watch"
	]

	grunt.loadNpmTasks npmTask for npmTask in grunt.npmTasks

	grunt.registerTask "build", [
		"browserify:dev"
	]

	grunt.registerTask "features", [
		"shell:kill" # Clean up any old selenium servers, or other programs who may be hogging 4444
		"shell:selenium"
		"shell:sleep"
		"cucumberjs:Edith"
		"shell:selenium:kill" # Stop the selenium server
		"shell:kill" # Also has the effect of killing driven browsers.
	]

	grunt.registerTask "test", [
		"mochaTest:server"
		"karma:unit"
		"features"
	]

	grunt.registerTask "default", [
		"build"
		"test"
	]
