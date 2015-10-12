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
    message.classList.add('inline-block')
    message.id = "timer"
    message.textContent = @timer
    @element.appendChild(message)

    # Placeholder for timer buttons
    toggleButton = document.createElement('div')
    toggleButton.classList.add('inline-block')
    toggleButton.style.backgroundColor = 'green'
    toggleButton.textContent = "Play/pause"
    @element.appendChild(toggleButton)

    stopButton = document.createElement('div')
    stopButton.classList.add('inline-block')
    stopButton.style.backgroundColor = 'red'
    stopButton.textContent = "Stop"
    @element.appendChild(stopButton)


  setTime: (time) ->
    if time.match(/^\d\d:\d\d$/g)
      @timer = startTime
      @element.children[0].textContent = @timer

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
