module.exports = (grunt)->
	grunt.Config =
		browserify:
			dev:
				files: "build/bundle.js": ["src/client/main.coffee"]
				options:
					debug: true
					transform: [
						"caching-coffeeify"
					]

		jade:
			index: files: "build/index.html": "src/client/index.jade"

		less:
			page:
				options:
					paths: [
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
						"http://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js"
						"http://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-animate.js"
						"http://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-mocks.js"
						"build/bundle.js"
						"src/client/**/unit.coffee"
					]
		uglify:
			all:
				files:
					'build/bundle.min.js': ["build/bundle.js"]

		cssmin:
			all: files: 'build/page.min.css': ["build/page.css"]

		watch:
			build:
				files: [
					'src/client/**/*jade'
					'src/client/**/*coffee'
					'src/client/**/*less'
				]
				tasks: ['build']

	grunt.NpmTasks = [
		"grunt-browserify"
		"grunt-contrib-jade"
		"grunt-contrib-less"
		"grunt-karma"
		"grunt-contrib-uglify"
		"grunt-contrib-cssmin"
		"grunt-contrib-watch"
	]

	grunt.registerTask "build", "Compile various sources into three bundles.", [
		"browserify:dev"
		"jade:index"
		"less:page"
	]
