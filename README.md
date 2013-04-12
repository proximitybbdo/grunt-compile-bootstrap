# What

This is a basic Gruntjs setup for

- Sass
- Coffeescript
	- concatinated
	- minified
- Watch task

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

Of course you need node.js.
You start by installing the necessary node packages (defined in `package.json`).

`$ npm install`

Make sure you add the `node_modules` directory in your `.gitignore`.

## Commands

Start the main task:

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

You can include the main.min.js in production or main.js in development.