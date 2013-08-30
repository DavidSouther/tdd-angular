#/bin/sh

function fin(){
	echo "Cleaning up"
	git co develop
	git stash pop
	
	# Fix bower
	rm -rf bower_components
	bower install
}

git stash
git co master
git reset --hard develop

if grunt base
then
	echo "Cutting release and pushing to heroku."
	echo -n
else
	echo "Cowardly not pushing with failing base build."
	fin
	exit 1
fi

git add --force build
git add --force bower_components/angular/angular.js
git add --force bower_components/bootstrap/fonts

git commit -m 'Release'

echo "Files in release:"
git ls-files

git push -f heroku master

# Test against heroku
SERVER=$(heroku apps:info | grep 'Web URL' | awk '{print $3}') grunt features

fin
