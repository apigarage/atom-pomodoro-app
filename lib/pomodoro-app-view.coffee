module.exports =
class PomodoroAppView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('pomodoro-app')
    @element.classList.add('inline-block')

    # Create message element
    message = document.createElement('div')
    message.textContent = "20:13"
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
