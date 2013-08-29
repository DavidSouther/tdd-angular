require("bower")
.commands
.install()
.on('end', function (installed) {
	console.log(installed);
	require("grunt").tasks("build");
});
