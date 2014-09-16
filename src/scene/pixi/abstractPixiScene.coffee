class Terra.Scene.PixiScene extends Terra.Scene.AbstractScene
  constructor: ->
    #setup pixi.js stage
    @container = document.getElementById('container')
    @height = container.clientHeight
    @width = container.clientWidth
    @stage = new PIXI.Stage(0xFFFFFF)
    @renderer = PIXI.autoDetectRenderer @width, @height
    container.appendChild @renderer.view
    
  run: ->
    @renderer.render @stage