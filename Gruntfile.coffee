module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  # Project configuration.
  grunt.initConfig
    vendorlibs:['assets/js/vendor/*.js', 'assets/js/base.js']

    less:
      development:
        options:
          paths: ["assets/css"]
        files:
          "assets/css/style.css": [
            "assets/css/lib/*.less"
            "assets/css/style.less"
          ]

      production:
        options:
          paths: ["assets/css"],
          yuicompress: true
        files:
          "assets/css/style.css": [
            "assets/css/lib/*.less"
            "assets/css/style.less"
          ]

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
      less:
        files: ['assets/css/**/*.less']
        tasks: ['less:development']

  # Default task.
  grunt.registerTask 'default', [
    'less:development'
    'coffee'
    'jshint'
  ]

  # deploy
  grunt.registerTask 'deploy', [
    'less:production'
    'coffee'
    'jshint'
    'concat'
    'uglify'
    'imagemin'
  ]
