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
