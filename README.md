## BDD / TDD Angular
[![Build Status](https://travis-ci.org/DavidSouther/tdd-angular.png)](https://travis-ci.org/DavidSouther/tdd-angular)

[Obey the Testing Goat!](3)

[Fear the Refactoing Cat!](20)

### [Why?](1) (for a NodeJS stack)

As a node developer, I want a rock-solid continuous deployment infrastructure so that I can return to my projects later and continue adding new features without accidentaly breaking code I wrote years ago.

As a technologist, I want to play with bleeding edge technologies so that I can squeeze the most out of their potential.

### What (Technologies)

The entire stack is Javascript, with one deploy script in bash that really should be rewritten to JS. The JSis written in Coffeescript where possible, which is pretty much everywhere.

* Engine: [Node.js](2), [NPM](19)
* Build: [Grunt](4)
* Behaviors: [Cucumber.js](5), [Selenium Webdriver JS](6), [Protractor](7)
* Server: [Express](8), [Mocha](9)
* Client: [AngularJS](10), [Browserify](22), [Karma](11), [Jasmine](12)
* Languages / Frameworks: [Coffeescript](15), [Jade](16), [Bootstrap](17), [Less](18)
* Continuous Integration: [Travis CI](13)
* Hosting: [Github](21), [Heroku](14)

### How (does the process work?)

![TDD Process with functional tests driving unit tests driving implementation. Credit Harry Percival / Test-Driven Web Development with Python][tdd]

TDD Process with functional tests driving unit tests driving implementation. [Credit Harry Percival / Test-Driven Web Development with Python][tdd-cite]

### Where (is the code?)

#### Source files

```sh
.
|-- .travis.yml
|-- bower.json
|-- package.json
|-- Gruntfile.coffee # Root Gruntfile. Defines cross-cutting watchers, and includes component Grunts.
|-- Procfile	     # Heroku configs
|-- README.md	     # This file!
`-- src
    |-- client 	1 Files that will be compiled and sent to the browser
    |   |-- Gruntfile.coffee # Build steps and angular unit test runners
    |   |-- index.jade 	     # Root HTML template
    |   |-- lib              # Internal library code, mostly cross-cutting helpers.
    |   |   `-- mixins.less    # Library of helpful less mixins
    |   |-- main.coffee      # Requires the various components. Entry file for browserify.
    |   |-- page.less        # Page-wide styling. 
    |   `-- todo             # Todo module.
    |       |-- module.coffee  # Module definition and controller
    |       |-- style.less
    |       |-- template.jade
    |       `-- unit.coffee    # The only file referenced by Grunt. Others are required or imported.
    |-- deploy   # Deployent helper scripts
    |   |-- grunt
    |   |   `-- recurse.coffee # Extensions to Grunt for easy recursion
    |   |-- release.sh  # Builds & tests. On successful test, commits built files to master and deploys.
    |   `-- start.js    # JS bootstrap to require coffee.
    |-- features
    |   |-- behavior
    |   |   |-- steps	1 Implementations of behavior steps.
    |   |   |   |-- browsing.coffee  # Browser-general ("browse to base, enter into text field")
    |   |   |   |-- buildmore.coffee # Sentinal reminder to build more features!
    |   |   |   |-- stylistic.coffee # Stylistic steps ()
    |   |   |   |-- todo.coffee      # Application-specific steps ("remove item")
    |   |   |   `-- world.coffee     # Before/After wrapper to include correct world
    |   |   |-- support
    |   |   |   |-- worlds  # Two different world definitions.
    |   |   |   |   |-- protractor.coffee
    |   |   |   |   `-- zombie.coffee # Has problems with Angular. I'd like to use it, but protractor works for now.
    |   |   |   `-- worlds.coffee
    |   |   `-- users   # Scenarios for each of the categorical users.
    |   |       |-- edith
    |   |       |   `-- Edith.feature
    |   |       `-- jason
    |   |           `-- Jason.feature
    |   `-- Gruntfile.coffee # Grunt tasks for starting selenium and running cucumber features.
    `-- server  # Tiny application server, that really just serves the 4 or 5 bundle files.
        |-- Gruntfile.coffee
        |-- server.coffee
        `-- test
            |-- port.coffee
            `-- serves.coffee
```


#### Generated files
```sh
.
|-- bower_components  # Used 
|   |-- bootstrap
|   |   |-- fonts  # Included in bundle to serve.
|   |   |-- less
|   |   |   |-- bootstrap.less # Less entry point
|-- build # Built bundle files
|   |-- bundle.js  # All javascript
|   |-- bundle.min.js # (minified)
|   |-- index.html # All HTML, merged into a single file.
|   |-- page.css   # All CSS, including bootstrap.
|   `-- page.min.css #(minified)
|-- coverage # Generated code coverage reports. (Currently only for bundle.js)
|-- node_modules
`-- selenium # Installed Selenium server.
```

### [Who](23) (is this guy?)

Just a lazy engineer who thinks the browser is the easiest platform to get code out on. A guy passionate about software, who loves the metaphor that programming is like drawing water from a well. If it's a shallow well and a small bucket, it's pretty easy. When it gets deeper, and a bigger bucket, it takes a lot more effort - until you have a winch.

### When

[MIT license](24)

Copyright 2013 David Souther

[1]: http://chimera.labs.oreilly.com/books/1234000000754/pr01.html1_why_i_wrote_a_book_about_test_driven_development
[2]: http://nodejs.org
[3]: http://obeythetestinggoat.com
[4]: http://gruntjs.com/
[5]: https://github.com/cucumber/cucumber-js
[6]: https://npmjs.org/package/selenium-webdriver
[7]: https://github.com/angular/protractor
[8]: http://expressjs.com/
[9]: http://visionmedia.github.io/mocha/
[10]: http://angularjs.org/
[11]: http://karma-runner.github.io/0.10/index.html
[12]: http://pivotal.github.io/jasmine/
[13]: https://travis-ci.org/
[14]: https://dashboard.heroku.com/apps
[15]: http://coffeescript.org/
[16]: http://jade-lang.com/
[17]: http://getbootstrap.com/
[18]: http://lesscss.org/
[19]: https://npmjs.org/
[20]: http://d22zlbw5ff7yk5.cloudfront.net/images/stash-397-50c133ecb9e66.gif
[21]: https://github.com/
[22]: https://github.com/substack/node-browserify
[23]: http://davidsouther.com/
[24]: http://opensource.org/licenses/MIT
[tdd]: http://orm-chimera-prod.s3.amazonaws.com/1234000000754/images/tdd_flowchart_functional_and_unit.png
[tdd-cite]: http://chimera.labs.oreilly.com/books/1234000000754/ch04.html#_recap_the_tdd_process