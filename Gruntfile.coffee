module.exports = (grunt)->
	grunt.initConfig
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

	grunt.npmTasks = [
		"grunt-cucumber"
		"grunt-mocha-test"
	]

	grunt.loadNpmTasks npmTask for npmTask in grunt.npmTasks

	grunt.registerTask "test", [
		"mochaTest:server"
		"cucumberjs:Edith"
	]
	grunt.registerTask "default", ["test"]
