PomodoroAppView = require './pomodoro-app-view'
{CompositeDisposable} = require 'atom'

module.exports = PomodoroApp =
  pomodoroAppView: null
  modalPanel: null
  subscriptions: null
  localStatusBarTile: null

  activate: (state) ->
    @pomodoroAppView = new PomodoroAppView(state.pomodoroAppViewState)

    # @modalPanel = atom.workspace.addModalPanel(item: @pomodoroAppView.getElement(), visible: false)
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pomodoro-app:toggle': => @toggle()


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pomodoroAppView.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null

  serialize: ->
    pomodoroAppViewState: @pomodoroAppView.serialize()

  consumeStatusBar: (statusBar) ->
    console.log('I m inside consume status bar function')
    @localStatusBarTile = statusBar.addRightTile(item: this.pomodoroAppView.getElement(), priority: 100)

  toggle: ->
    console.log 'PomodoroApp was toggled!'
    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
