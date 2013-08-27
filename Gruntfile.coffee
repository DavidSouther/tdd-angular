module.exports = (grunt)->
	grunt.initConfig
		browserify:
			dev:
				files: "build/bundle.js": ["src/client/main.coffee"]
				options:
					debug: true
					transform: [
						"caching-coffeeify"
					]

		jade:
			index:
				files:
					"build/index.html": "src/client/index.jade"

		less:
			page:
				options:
					paths:[
						"bower_components/bootstrap/less"
					]
				files:
					"build/page.css": ["src/client/page.less"]

		karma:
			unit:
				options:
					browsers: ["PhantomJS"]
					frameworks: ["jasmine"]
					preprocessors:
						"src/client/bundle.js": "coverage"
						"src/**/*.coffee": "coffee"
					reporters: [
						'coverage'
						'dots'
					]
					singleRun: true
					files: [
						"bower_components/angular/angular.js"
						"bower_components/angular-mocks/angular-mocks.js"
						"build/bundle.js"
						"src/client/**/unit.coffee"
					]

		mochaTest:
			server:
				options:
					reporter: 'spec'
				src: ["src/server/test/*coffee"]

		shell:
			kill:
				command: "lsof -i TCP -P | grep 4444 | awk '{print $2}' | xargs -I{} kill {} >/dev/null  || exit 0"
			install:
				command: "[ -f ./selenium/selenium-server-standalone-2.34.0.jar ] || ./node_modules/protractor/bin/install_selenium_standalone"
			selenium:
				command: [
					"java -jar ./selenium/selenium-server-standalone-2.34.0.jar"
					"-Dwebdriver.chrome.driver=./selenium/chromedriver"
					# "-log selenium.log -browserSideLog"
					">/dev/null"
				].join ' '
				options:
					async: true
					kill: true
			sleep:
				command:
					"sleep 1"

		cucumberjs:
			all:
				files:
					src: ['src/features/behavior/users/*']
			current:
				files:
					src: ['src/features/behavior/users/*']
				options:
					tags: '@current'

			options:
				steps: 'src/features/behavior/steps'

		watch:
			build:
				files:[
					'src/client/**/*jade'
					'src/client/**/*coffee'
					'src/client/**/*less'
				]
				tasks: ['build']
			all:
				files: [
					'src/features/**/*coffee'
					'src/features/**/*feature'
					'src/server/**/*coffee'
					'src/client/**/*jade'
					'src/client/**/*coffee'
					'src/client/**/*less'
				]
				tasks: ['default']

	grunt.npmTasks = [
		"grunt-cucumber"
		"grunt-karma"
		"grunt-shell-spawn"
		"grunt-browserify"
		"grunt-mocha-test"
		"grunt-contrib-jade"
		"grunt-contrib-less"
		"grunt-contrib-watch"
	]

	grunt.loadNpmTasks npmTask for npmTask in grunt.npmTasks

	grunt.registerTask "build", [
		"browserify:dev"
		"jade:index"
		"less:page"
	]

	grunt.registerTask "features", [
		"shell:kill" # Clean up any old selenium servers, or other programs who may be hogging 4444
		"shell:install"
		"shell:selenium"
		"shell:sleep"
		"cucumberjs:all"
		"shell:selenium:kill"
		"shell:kill" # Also has the effect of killing driven browsers.
	]

	grunt.registerTask "feature", [
		"shell:kill" # Clean up any old selenium servers, or other programs who may be hogging 4444
		"shell:install"
		"shell:selenium"
		"shell:sleep"
		"cucumberjs:current"
		"shell:selenium:kill"
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
