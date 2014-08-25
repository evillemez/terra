#app namespaces
Terra =
  Voronoi: {}
  Event: {}
  Terrain: {}

###
# Create and render a Voronoi diagram.
###
voronoi = ->
  #setup stage
  @container = document.getElementById('container')
  @height = container.clientHeight
  @width = container.clientWidth
  @stage = new PIXI.Stage(0xFFFFFF)
  @renderer = PIXI.autoDetectRenderer width, height
  @container.appendChild renderer.view
  
  #build and display voronoi graph
  @voronoi = new Terra.Voronoi.Diagram(width, height, 50)
  console.log "Voronoi computed in #{voronoi.time} ms."

  @voronoiRenderer = new Terra.Voronoi.Renderer(stage, voronoi)
  @voronoiRenderer.draw()
  console.log "Voronoi rendered in #{voronoiRenderer.time} ms."
    
  #render the scene
  @renderer.render stage  

###
# Create and render a 3D terrain chunk.
###
terrain = ->
  

#do stuff once DOM loads
document.addEventListener 'DOMContentLoaded', voronoi.bind window