module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  # Project configuration.
  grunt.initConfig
    vendorlibs:['assets/js/vendor/*.js', 'assets/js/base.js']
    compass:
      app:
        options:
          require: ['compass-h5bp'] #to use compass libs ex: ,'ceaser-easing'
          sassDir: 'assets/css'
          cssDir: 'assets/css'
          imagesDir: 'assets/img'
          fontsDir: 'assets/font'
          httpPath: "/"
          relativeAssets: true
          boring: true
          debugInfo: true
          outputStyle: 'compressed'
          raw: 'preferred_syntax = :sass\n'

    coffee:
      app:
        files: [
          expand: true
          preserve_dirs: true
          bare: false
          cwd: 'assets/coffee'
          src: ['**/*.coffee']
          dest: 'assets/js'
          ext: '.js'
        ]

    requirejs:
      compile:
        options:
          mainConfigFile: 'assets/js/build.js'
          baseUrl: "assets/js"
          name: "base"
          include: ['templates', 'build']
          insertRequire: ['templates']
          out: 'assets/js/base.min.js'
          preserveLicenseComments: false

    jshint:
      app:
        options:
          boss: true
          expr: true
          eqnull: true
        files:
          src: 'assets/js/*.js'

    concat:
      options:
        stripBanners: true
      dist:
        src: '<%= vendorlibs %>'
        dest: 'assets/js/app.js'

    uglify:
      app:
        options:
          sourceMap: 'assets/js/app.js.map'
        files:
          'assets/js/app.min.js': ['assets/js/app.js']

    imagemin:
      dist:
        options:
          optimizationLevel: 3
        files: [
            expand: true,
            cwd: "assets/img/"
            src: "**/*.{png,jpg,jpeg}"
            dest: "assets/img/"
        ]

    watch:
      app:
        files: ['assets/coffee/**/*.coffee']
        tasks: ['coffee']
      sass:
        files: ['assets/css/**/*.sass']
        tasks: ['compass']
      scss:
        files: ['assets/css/**/*.scss']
        tasks: ['compass']

  # Default task.
  grunt.registerTask 'default', [
    'compass'
    'coffee'
    'jshint'
  ]

  # deploy
  grunt.registerTask 'deploy', [
    'compass'
    'coffee'
    'jshint'
    'concat'
    'uglify'
    'imagemin'
  ]
