module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig({
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
          'assets/js/main.js': ['assets/coffee/**/*.coffee']

    jshint:
      options:
        boss: true
        expr: true
        eqnull: true
        files: ['assets/js/main.js']

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
  grunt.registerTask 'default', ['compass', 'coffee:app', 'jshint', 'jsmin-sourcemap']
