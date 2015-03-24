# TODO: grunt-grunticon
DEV = true

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  path =
    client: 'src/client/'
    server: 'src/server/'

  config =
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      client:
        options:
          join: true
        files:
          'build/client.js': [
            path.client + 'config.coffee'
            path.client + 'core/utils.coffee'
            path.client + 'core/math.coffee'
            path.client + 'game/animation.coffee'
            path.client + 'game/camera.coffee'
            path.client + 'game/player.coffee'
            path.client + 'game/bed.coffee'
            path.client + 'game/lava.coffee'
            path.client + 'interface/stats.coffee'
            path.client + 'multiplayer.coffee'
            path.client + 'start.coffee'
          ]
      server:
        options:
          join: true
        files:
          'build/server.js': [
            path.server + 'player.coffee'
            path.server + 'start.coffee'
          ]

    bower_concat:
      all:
        dest: 'build/lib.js'
        mainFiles:
          'pixi.js': 'bin/pixi.dev.js'

    uglify:
      client:
        src: 'build/client.js'
        dest: 'build/client.js'
      server:
        src: 'build/client.js'
        dest: 'build/client.js'
      clientLib:
        src: 'build/lib.js'
        dest: 'build/lib.js'

    watch:
      client:
        files: ['src/client/**/*.coffee']
        tasks: ['coffee:client']
      server:
        files: ['src/server/**/*.coffee']
        tasks: ['coffee:server']
      bower:
        files: ['bower.json']
        tasks: ['bower_concat']
      gruntfile:
        files: 'Gruntfile.coffee'
        options:
          reload: true

  if DEV is false
    config.watch.client.tasks.push 'uglify:client'
    config.watch.server.tasks.push 'uglify:server'
    config.watch.bower.tasks.push 'uglify:clientLib'

  grunt.initConfig config

  grunt.registerTask 'default', 'watch'