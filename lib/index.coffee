PomodoroAppView = require './pomodoro-app-view'
{CompositeDisposable} = require 'atom'

module.exports = PomodoroApp =
  config:
    startTime:
      type: 'integer'
      default: 25
      minimum: 0
      maximum: 60
    smallBreak:
      type: 'integer'
      default: 5
      minimum: 0
      maximum: 60
    longBreak:
      type: 'integer'
      default: 25
      minimum: 0
      maximum: 60

  DEBUG: true
  pomodoroAppView: null
  subscriptions: null
  localStatusBarTile: null
  timerState: 'D'

  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:toggleTimer': => @toggleTimer()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:stopTimer': => @stopTimer()

    timerState:'D'
    # This code will be used for registering commands (using ctrl+shift+p).
    # # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    # @subscriptions = new CompositeDisposable
    #
    # # Register command that toggles this view
    # @subscriptions.add atom.commands.add 'atom-workspace', 'pomodoro-app:toggle': => @toggle()


  deactivate: ->
    # @subscriptions.dispose()
    @pomodoroAppView.destroy() # All hell goes loose
    @statusBarTile?.destroy()
    @statusBarTile = null

  serialize: ->
    pomodoroAppViewState: @pomodoroAppView.serialize()

  consumeStatusBar: (statusBar) ->
    @localStatusBarTile = statusBar.addRightTile(item: this.pomodoroAppView.getElement(), priority: 100)

  toggleTimer: ->
    console.log if @DEBUG and (@timerState is 'D' or @timerState is 'P') then 'Timer running' else 'Timer paused'
    @timerState = if (@timerState is 'D' or @timerState is 'P') then 'R' else 'P'

  stopTimer: ->
    if @DEBUG and (@timerState is 'R' or @timerState is 'P') then console.log 'Timer off'
    @timerState = 'D'

  # toggle: ->
  #   console.log 'PomodoroApp was toggled!'
