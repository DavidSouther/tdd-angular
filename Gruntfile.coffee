module.exports = (grunt)->
	require("./recurse")(grunt)

	[
		"./src/client"
		"./src/server"
		"./src/features"
	].map grunt.grunt


	###
	The root Gruntfile simply manages several tasks, defined elsewhere.
	It watches some types of files, and composes some high-level helper tasks.
	###

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

	grunt.registerTask "test", "Run all the tests.", [
		"mochaTest:server"
		"karma:unit"
		"features"
	]

	grunt.registerTask "base", "Perform a base level of production, up to but not including features.", [
		'build'
		'mochaTest:server'
		'karma:unit'
	]

	grunt.registerTask "compress", "Compress CSS and JS bundles.", [
		"uglify:all"
		"cssmin:all"
		# Modify index.html to use min files
	]

	grunt.registerTask "default", "Prepare the full project for deployment, including running all tests.", [
		"build"
		"test"
		"compress"
	]

	grunt.initConfig grunt.Config
	grunt.loadNpmTasks npmTask for npmTask in grunt.NpmTasks
