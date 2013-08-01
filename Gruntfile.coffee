module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    compass:
      app:
        options:
          sassDir: 'assets/css'
          cssDir: 'assets/css'
          imagesDir: 'assets/img'
          fontsDir: 'assets/fonts'
          httpPath: "/"
          relativeAssets: true
          boring: true
          debugInfo: true
          outputStyle: 'compressed'
          # enable_sourcemaps: true
          raw: '{:preferred_syntax => :sass, :sourcemap => true}\n'
          require: []

    'jsmin-sourcemap':
      all:
        # Source files to concatenate and minify (also accepts a string and minimatch items)
        src: ['assets/js/main.js']
        # Destination for concatenated/minified JavaScript
        dest: 'assets/js/main.min.js'
        # Destination for sourcemap of minified JavaScript
        destMap: 'assets/js/main.js.map'
        # Optional root for all relative URLs
        srcRoot: '../..'

    coffee:
      app:
        options:
          sourceMap: true
          bare: false
          join: true
        files:
          'assets/js/main.js': ['assets/coffee/**/*.coffee']

    jshint:
      app:
        options:
          boss: true
          expr: true
          eqnull: true
        files:
          src: 'assets/js/site/base.js'

    watch:
      app:
        files: ['assets/coffee/**/*.coffee']
        tasks: ['coffee', 'jsmin-sourcemap']
      sass:
        files: ['assets/css/*.sass']
        tasks: ['compass']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-jsmin-sourcemap'

  # Default task.
  grunt.registerTask 'default', ['compass', 'coffee', 'jshint', 'jsmin-sourcemap']
