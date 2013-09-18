module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  # Project configuration.
  grunt.initConfig
    vendorlibs:['assets/js/vendor/*.js', 'assets/js/base.js']

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

  # Default task.
  grunt.registerTask 'default', [

    'coffee'
    'jshint'
  ]

  # deploy
  grunt.registerTask 'deploy', [

    'coffee'
    'jshint'
    'concat'
    'uglify'
    'imagemin'
  ]
