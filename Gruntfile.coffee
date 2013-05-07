module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig({
    vendorlibs:['assets/js/vendor/*.js', 'assets/js/base.js']
    compass:
      dist:
        options:
          config: 'config.rb'
          sassDir: 'assets/css'
          cssDir: 'assets/css'
          imagesDir: 'assets/img'
          fontsDir: 'assets/fonts'

    coffee:
      app:
        options:
          sourceMap: true
          bare: false,
          join: true
        files:
          'assets/js/base.js': ['assets/coffee/**/*.coffee']

    jshint:
      options:
        boss: true
        expr: true
        eqnull: true
        files: ['assets/js/base.js']

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
        tasks: ['coffee:app', 'jsmin-sourcemap']
      sass:
        files: ['assets/css/*.sass']
        tasks: ['compass']
  })

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-jsmin-sourcemap'

  # Default task.
  grunt.registerTask 'default', ['compass', 'coffee', 'jshint']
  # deploy
  grunt.registerTask 'deploy', ['compass', 'coffee', 'jshint', 'concat', 'uglify']
