module.exports = (grunt)->
	grunt.Config =
		cucumberjs:
			all:
				files:
					src: ['src/features/behavior/users/*']
				options:
					tags: '~@broken'
			current:
				files:
					src: ['src/features/behavior/users/*']
				options:
					tags: '@current'

			options:
				steps: 'src/features/behavior/steps'

	grunt.NpmTasks = [
		"grunt-cucumber"
		"grunt-selenium-launcher"
	]

	grunt.registerTask "features", "Run all feature behaviors, except those tagged @broken.", [
		'selenium-launch'
		"cucumberjs:all"
	]

	grunt.registerTask "feature", "Runs feature behaviors tagged @current.", [
		'selenium-launch'
		"cucumberjs:current"
	]
