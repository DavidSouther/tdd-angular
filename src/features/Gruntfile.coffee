module.exports = (grunt)->
	grunt.Config =
		shell:
			kill:
				command: [
					"ps | grep node | awk '{print $1}' | xargs -I{} kill {} >/dev/null"
					"ps | grep java | awk '{print $1}' | xargs -I{} kill {} >/dev/null"
					"exit 0"
				].join " ; "
			install:
				command: "[ -f ./selenium/selenium-server-standalone-2.34.0.jar ] || ./node_modules/protractor/bin/install_selenium_standalone"
			serve:
				command: "npm start ; exit 0"
				options:
					async: true
					kill: true
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
				options:
					tags: '~@broken'
					format: 'pretty'
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

	grunt.registerTask "features", "Run all feature behaviors, except those tagged @broken.", [
		"shell:install"
		"shell:selenium"
		"shell:sleep"
		"cucumberjs:all"
		"shell:selenium:kill"
		"shell:kill"
	]

	grunt.registerTask "feature", "Runs feature behaviors tagged @current.", [
		"shell:install"
		"shell:selenium"
		"shell:sleep"
		"cucumberjs:current"
		"shell:selenium:kill"
		"shell:kill"
	]

