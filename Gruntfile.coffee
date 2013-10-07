module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    config:
      src: 'assets/coffee'
      dest: 'assets/js'

    clean:
      build:
        src: ['<%= config.dest %>/*', '!<%= config.dest %>/vendor']

    notify:
      watch:
        options:
          title: "Watch",
          message: "Watch compile completed"

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
        src: ['<%= config.dest %>/main.js']
        dest: '<%= config.dest %>/main.min.js'
        destMap: '<%= config.dest %>/main.js.map'
        srcRoot: '../..'

    coffee:
      app:
        options:
          sourceMap: true
          bare: false
          join: true
        files:
          '<%= config.dest %>/main.js': ['<%= config.src %>/**/*.coffee']

    # jshint:
    #   app:
    #     options:
    #       boss: true
    #       expr: true
    #       eqnull: true
    #     files:
    #       src: '<%= config.dest %>/main.js'

    imagemin:
      dist:
        options:
          optimizationLevel: 3
        files: [
            expand: true,
            cwd: "assets/img/",
            src: "**/*.{png,jpg,jpeg}"
            dest: "assets/img/"
        ]

    watch:
      options:
        spawn: false
        interrupt: true
        atBegin: true
        interval: 500
      app:
        files: ['<%= config.src %>/**/*.coffee']
        tasks: ['any-newer:coffee']
      sass:
        files: ['assets/css/*.sass']
        tasks: ['compass']

    concurrent:
      compile: ['compass', 'coffee', 'jsmin-sourcemap']
      optimize: ['imagemin']

  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # Tasks
  grunt.registerTask 'default', ['concurrent:compile']
  grunt.registerTask 'production', ['clean', 'concurrent:compile', 'concurrent:optimize']
