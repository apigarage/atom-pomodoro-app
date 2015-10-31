PomodoroAppView = require './pomodoro-app-view'
Timer = require './timer'
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
  togleButton: null
  stopButton: null
  timer: null

  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)
    @timer = new Timer(atom.config.get("atom-pomodoro-app.startTime"), @pomodoroAppView.getTimerContainer())
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:toggleTimer': => @toggleTimer()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:stopTimer': => @stopTimer()
    # Assigning event listeners
    @togleButton = @pomodoroAppView.getToggleButton()
    @stopButton = @pomodoroAppView.getStopButton()
    @togleButton.addEventListener 'click', =>@toggleTimer()
    @stopButton.addEventListener 'click', =>@stopTimer()
    @stopButton.disabled = true
    # This code will be used for registering commands (using ctrl+shift+p).
    # # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    # @subscriptions = new CompositeDisposable
    #
    # # Register command that toggles this view
    # @subscriptions.add atom.commands.add 'atom-workspace', 'pomodoro-app:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()
    @pomodoroAppView.destroy() # All hell goes loose
    @statusBarTile?.destroy()
    @statusBarTile = null

  serialize: ->
    pomodoroAppViewState: @pomodoroAppView.serialize()

  consumeStatusBar: (statusBar) ->
    @localStatusBarTile = statusBar.addRightTile(item: this.pomodoroAppView.getElement(), priority: 100)

  toggleTimer: ->
    @timer.toggle()
    @stopButton.disabled = false

  stopTimer: ->
    @timer.reset()
    @stopButton.disabled = true


  # toggle: ->
  #   console.log 'PomodoroApp was toggled!'
