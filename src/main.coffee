#app namespaces
Terra =
  Voronoi: {}

#do stuff once DOM loads
document.addEventListener 'DOMContentLoaded', ->

  #setup stage
  container = document.getElementById('container')
  height = container.clientHeight
  width = container.clientWidth
  stage = new PIXI.Stage(0xFFFFFF)
  renderer = PIXI.autoDetectRenderer width, height
  container.appendChild renderer.view
  
  #build and display voronoi graph
  voronoi = new Terra.Voronoi.Diagram(width, height, 10)
  console.log "Voronoi computed in #{voronoi.time} ms."

  voronoiRenderer = new Terra.Voronoi.Renderer(stage, voronoi)
  voronoiRenderer.draw()
  console.log "Voronoi rendered in #{voronoiRenderer.time} ms."
    
  #render the scene
  renderer.render stage
  