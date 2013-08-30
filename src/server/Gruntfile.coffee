module.exports = (grunt)->
	grunt.Config =
		mochaTest:
			server:
				options:
					reporter: 'spec'
				src: ["src/server/test/*coffee"]

	grunt.NpmTasks.push "grunt-mocha-test"
