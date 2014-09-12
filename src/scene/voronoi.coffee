###
# Create and render a Voronoi diagram.
###
class Terra.Scene.Voronoi
  constructor: ->
    @name = '2d Voronoi Diagram'
  
  run: ->
    #setup pixi.js stage
    container = document.getElementById('container')
    height = container.clientHeight
    width = container.clientWidth
    stage = new PIXI.Stage(0xFFFFFF)
    renderer = PIXI.autoDetectRenderer width, height
    container.appendChild renderer.view
  
    #build and display voronoi graph
    voronoi = new Terra.Voronoi.Diagram(width, height, 50)
    console.log "Voronoi computed in #{voronoi.time} ms."

    voronoiRenderer = new Terra.Voronoi.Renderer(stage, voronoi)
    voronoiRenderer.draw()
    console.log "Voronoi rendered in #{voronoiRenderer.time} ms."
    
    #render the scene
    renderer.render stage  
    