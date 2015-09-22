PomodoroAppView = require './pomodoro-app-view'
{CompositeDisposable} = require 'atom'

module.exports = PomodoroApp =
  pomodoroAppView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @pomodoroAppView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pomodoro-app:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pomodoroAppView.destroy()

  serialize: ->
    pomodoroAppViewState: @pomodoroAppView.serialize()

  toggle: ->
    console.log 'PomodoroApp was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
