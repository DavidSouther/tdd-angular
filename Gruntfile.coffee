module.exports = (grunt)->
	require("./recurse")(grunt)

	grunt.NpmTasks = [ "grunt-contrib-watch" ]

	grunt.Config =
		watch:
			base:
				files:[
					'src/client/**/*jade'
					'src/client/**/*coffee'
					'src/client/**/*less'
					'src/server/**/*coffee'
				]
				tasks: [ 'base' ]
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

	[
		"./src/client"
		"./src/server"
		"./src/features"
	].map grunt.grunt

	grunt.initConfig grunt.Config
	grunt.loadNpmTasks npmTask for npmTask in grunt.NpmTasks

	grunt.registerTask "test", [
		"mochaTest:server"
		"karma:unit"
		"features"
	]

	grunt.registerTask "base", [
		'build'
		'mochaTest:server'
		'karma:unit'
	]

	grunt.registerTask "compress", [
		"uglify:all"
		"cssmin:all"
	]

	grunt.registerTask "default", [
		"build"
		"test"
		"compress"
	]
