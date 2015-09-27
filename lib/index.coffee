PomodoroAppView = require './pomodoro-app-view'
{CompositeDisposable} = require 'atom'

module.exports = PomodoroApp =
  config:
    startTime:
      type: 'integer'
      default: 25
      minimum: 0
    smallBreak:
      type: 'integer'
      default: 5
      minimum: 0
    longBreak:
      type: 'integer'
      default: 30
      minimum: 0

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
