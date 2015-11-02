module.exports = PomodoroApp =
class PomodoroAppView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('pomodoro-app')
    @element.classList.add('inline-block')

    # Placeholder for timer buttons
    # Play/pause button
    toggleButton = document.createElement('input')
    toggleButton.id = "toggle"
    toggleButton.setAttribute("type", "button")
    toggleButton.setAttribute("value", "Start/Pause")
    toggleButton.classList.add('inline-block')
    toggleButton.style.backgroundColor = 'green'
    @element.appendChild(toggleButton)

    # Stop button
    stopButton = document.createElement('input')
    stopButton.setAttribute("type", "button")
    stopButton.setAttribute("value", "Stop")
    stopButton.classList.add('inline-block')
    stopButton.style.backgroundColor = 'red'
    @element.appendChild(stopButton)

    # Create timer block
    @timer = atom.config.get("atom-pomodoro-app.startTime") + ":" + "00"
    message = document.createElement('div')
    message.style.margin = "0px 3px"
    message.classList.add('inline-block')
    message.id = "timer"
    message.textContent = @timer
    @element.appendChild(message)

  setTime: (time) ->
    if time.match(/^\d\d:\d\d$/g)
      @element.children[2].textContent = time
    console.log 'time set'

  getTimerContainer: () ->
    return @element.children[2]

  getStopButton: () ->
    return @element.children[1]

  getToggleButton: () ->
    return @element.children[0]
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
