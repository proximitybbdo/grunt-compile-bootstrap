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
        options:
          sourceMap: true
          bare: false
          join: true
        files:
          'assets/js/base.js': ['assets/coffee/**/*.coffee']

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
        src: '<%= vendorlibs %>',
        dest: 'assets/js/app.js'

    uglify:
      app:
        options:
          sourceMap: 'assets/js/app.js.map' # the sourcemap
        files:
          'assets/js/app.min.js': ['assets/js/app.js']

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
  grunt.registerTask 'default', ['compass', 'coffee', 'jshint']
  # deploy
  grunt.registerTask 'deploy', ['compass', 'coffee', 'jshint', 'concat', 'uglify']
