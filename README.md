# Grunt compile bootstrap

This is a basic [Grunt](http://gruntjs.com/) setup for

- Sass
- Coffeescript
	- concatinated
	- sourcemaps
- Javascript
	- minified
	- sourcemaps
- Watch tasks

## Directory setup

It assumes the following directory setup:

```
assets/
  js/
    *.js
  coffee/
    **/*.coffee
  img/
  fonts/
  css/
    *.sass
    *.css
```

## Installation

Of course you need [node.js](http://nodejs.org/).
You start by installing the necessary [node packages](https://npmjs.org/) (defined in `package.json`).

`$ npm install`

Make sure you add the `node_modules` directory in your `.gitignore`.
This will install the following packages:

- grunt-contrib-coffee
- grunt-contrib-compass
- grunt-contrib-watch
- grunt-jsmin-sourcemap
- grunt-contrib-jshint

## Commands

Start the default task:

`$ grunt`

Start the watch task for the coffeescripts:

`$ grunt watch:app`

Start the watch task for the sass files:

`$ grunt watch:sass`

## Resulting files

It produces the following files:

```
assets/
	js/
		main.js
		main.js.map
		main.map
		main.min.js
```

You can include the main.min.js in production or main.js for development purposes.

### Sourcemaps

The source maps allow you to debug the original javascript / Coffeescript files in your browser (use Chrome! if you don't already). 

[See](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) for more information.
