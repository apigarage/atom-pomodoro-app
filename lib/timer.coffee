module.exports = PomodoroApp =
class Timer
  DEBUG: true
  timerStateEnum:
    default : 'default'
    running : 'running'
    paused : 'paused'
  startTime: null
  tick: null
  minutes: null
  container: null
  milliseconds: null
  timerState: null
  constructor: (minutes, container) ->
    @timerState = @timerStateEnum.default
    @minutes = minutes
    @milliseconds = minutes * 60 * 1000
    @container = container

  activate: =>
    @startTime = new Date().getTime()
    @container.textContent = @minutes + ":00"
    @tick = setInterval(@increment, 500)

  pause: =>
    @milliseconds = @increment()
    clearInterval(@tick)

  resume: =>
    @startTime = new Date().getTime()
    @tick = setInterval(@increment, 500)

  # Increases
  increment: =>
    now = Math.max(0, @milliseconds-(new Date().getTime()-@startTime))
    minute = Math.floor(now/60000)
    second = Math.floor(now/1000)%60
    # 5 seconds will be 05 seconds
    second = (if second < 10 then "0" else "") + second
    @container.textContent = minute + ":" + second
    if ( now == 0 )
      clearInterval(@tick)
      @timerState = @timerStateEnum.default
    return now

  # Used to restore the timer to the default state
  reset: =>
    clearInterval(@tick)
    @container.textContent = @minutes + ":00"
    @milliseconds = @minutes * 60 * 1000
    @timerState = @timerStateEnum.default
    if @DEBUG then console.log "Timer "+ @timerState

  toggle: =>
    if @timerState is @timerStateEnum.default
      @timerState = @timerStateEnum.running
      @activate()
    else if @timerState is @timerStateEnum.paused
        @timerState = @timerStateEnum.running
        @resume()
    else
        @timerState = @timerStateEnum.paused
        @pause()
    if @DEBUG then console.log "Timer "+ @timerState

  getState: =>
    return @timerState
