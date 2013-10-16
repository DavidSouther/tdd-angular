module.exports = (grunt)->
	grunt.Config =
		mochaTest:
			server:
				options:
					reporter: 'spec'
				src: ["src/server/test/*coffee"]

	grunt.NpmTasks = "grunt-mocha-test"
