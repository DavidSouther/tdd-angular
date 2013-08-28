module.exports = (grunt)->
	grunt.Config =
		shell:
			kill:
				command: "lsof -i TCP -P | grep 4444 | awk '{print $2}' | xargs -I{} kill {} >/dev/null  || exit 0"
			install:
				command: "[ -f ./selenium/selenium-server-standalone-2.34.0.jar ] || ./node_modules/protractor/bin/install_selenium_standalone"
			selenium:
				command: [
					"java -jar ./selenium/selenium-server-standalone-2.34.0.jar"
					"-Dwebdriver.chrome.driver=./selenium/chromedriver"
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

	grunt.NpmTasks = [
		"grunt-cucumber"
		"grunt-shell-spawn"
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
		# Start the application server
		"shell:sleep"
		"cucumberjs:current"
		# Stop the application server
		"shell:selenium:kill"
		"shell:kill" # Also has the effect of killing driven browsers.
	]
