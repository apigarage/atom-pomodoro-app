PomodoroAppView = require './pomodoro-app-view'
{CompositeDisposable} = require 'atom'

module.exports = PomodoroApp =
  config:
    startTime:
      title: 'Start Time'
      type: 'object'
      properties:
        minute:
          type: 'integer'
          default: 25
          minimum: 0
          maximum: 59
        second:
          type: 'integer'
          default: 0
          maximum: 59
    smallBreak:
      type: 'object'
      properties:
        minute:
          type: 'integer'
          default: 25
          maximum: 59
        second:
          type: 'integer'
          default: 0
          maximum: 59
    longBreak:
      type: 'object'
      properties:
        minute:
          type: 'integer'
          default: 25
          maximum: 59
        second:
          type: 'integer'
          default: 0
          maximum: 59
  pomodoroAppView: null
  # subscriptions: null
  localStatusBarTile: null
  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)

    # This code will be used for registering commands (using ctrl+shift+p).
    # # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    # @subscriptions = new CompositeDisposable
    #
    # # Register command that toggles this view
    # @subscriptions.add atom.commands.add 'atom-workspace', 'pomodoro-app:toggle': => @toggle()


  deactivate: ->
    # @subscriptions.dispose()
    @pomodoroAppView.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null

  serialize: ->
    pomodoroAppViewState: @pomodoroAppView.serialize()

  consumeStatusBar: (statusBar) ->
    @localStatusBarTile = statusBar.addRightTile(item: this.pomodoroAppView.getElement(), priority: 100)

  # toggle: ->
  #   console.log 'PomodoroApp was toggled!'
