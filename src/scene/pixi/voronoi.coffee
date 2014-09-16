###
# Create and render a Voronoi diagram.
###
class Terra.Scene.Voronoi extends Terra.Scene.PixiScene
  
  setup: ->
  
    #build and display voronoi graph
    voronoi = new Terra.Voronoi.Diagram(@width, @height, 50)
    console.log "Voronoi computed in #{voronoi.time} ms."

    voronoiRenderer = new Terra.Voronoi.Renderer(@stage, voronoi)
    voronoiRenderer.draw()
    console.log "Voronoi rendered in #{voronoiRenderer.time} ms."
    