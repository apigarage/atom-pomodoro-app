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
  togleButton: null
  stopButton: null
  timerStateEnum:
    default : 'default'
    running : 'running'
    paused : 'paused'
  timerState: null

  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:toggleTimer': => @toggleTimer()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pomodoro-app:stopTimer': => @stopTimer()
    # Set timer state
    timerState = @timerStateEnum.default
    #
    @togleButton = @pomodoroAppView.getElement().getElementsByTagName('input')[0]
    @stopButton = @pomodoroAppView.getElement().getElementsByTagName('input')[1]
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
    if (@timerState is @timerStateEnum.default or
        @timerState is @timerStateEnum.paused)
          @timerState = @timerStateEnum.running
    else
        @timerState = @timerStateEnum.paused
    @stopButton.disabled = false
    if @DEBUG then console.log "Timer "+ @timerState

  stopTimer: ->
    @timerState = @timerStateEnum.default
    @stopButton.disabled = true
    if @DEBUG then console.log "Timer "+ @timerState

  # toggle: ->
  #   console.log 'PomodoroApp was toggled!'
