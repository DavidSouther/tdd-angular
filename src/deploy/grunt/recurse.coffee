Path = require "path"

module.exports = (grunt, root)->
	grunt.grunt = (path)->
		other = require "#{root}/#{path}/Gruntfile"
		other(grunt)

	Object.defineProperty grunt, "Config", do->
		_config = {}
		get: -> _config
		set: (val)->
			for t, c of val
				_config[t] = _config[t] || {}
				for k, v of c
					_config[t][k] = v
			grunt

	Object.defineProperty grunt, "NpmTasks", do->
		_tasks = []
		get: -> _tasks
		set: (val)->
			_tasks = _tasks.concat val
