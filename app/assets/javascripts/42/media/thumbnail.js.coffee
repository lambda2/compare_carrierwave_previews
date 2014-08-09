
class Core.Media.Thumbnail

  constructor: (@interval, @tag) ->
    @_hovered = null
    console.log(@tag)
    @tag ||= "[data-preview]"
    @interval ||= 400
    console.log(" => ", @tag)
    @listen()

  incrementFrame: (name, reset = false) ->
    ext = name.split(".").pop()
    f = name.split(".").slice(0, -1).join("").split("_")
    q = parseInt(f.pop())
    if reset then n = 0 else n = (q + 10) % 110
    [f.join("_"), n].join("_") + ".#{ext}"

  resetFrame: (name) ->
    @incrementFrame(name, true)

  listen: ->
    self = @
    $(@tag).hover(->
      console.log("Hover")
      if self._hovered is null
        self._hovered = setInterval =>
          $(@).attr("src", self.incrementFrame($(@).attr("src")))
        , self.interval
    , ->
      clearInterval(self._hovered)
      $(@).attr("src", self.resetFrame($(@).attr("src")))
      self._hovered = null
    )
