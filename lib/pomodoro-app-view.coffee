module.exports =
class PomodoroAppView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('pomodoro-app')
    @element.classList.add('inline-block')
    @timer = atom.config.get("atom-pomodoro-app.startTime") + ":" + "00"
    # Create message element
    message = document.createElement('div')
    message.id = "timer"
    message.textContent = @timer
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  setTime: (time) ->
    if time.match(/^\d\d:\d\d$/g)
      @timer = startTime
      @element.children[0].textContent = @timer

  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
