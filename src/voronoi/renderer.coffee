###
# Uses a PIXI graphics object to render a Terra.Voronoi.Diagram instance.
###
class Terra.Voronoi.Renderer
  constructor: (@stage, @diagram) ->
    @time = null
    
    @g = new PIXI.Graphics()
    stage.addChild @g
    
  draw: ->
    @g.clear()

    startTime = Date.now()

    @drawCentroids()
    @drawSites()
    @drawEdges()
    @fillCells()
    @drawVertices()

    @time = Date.now() - startTime

  drawSites: ->
    @g.lineStyle 2, 0x888888, 1

    for site in @diagram.sites
      @g.moveTo site.x, site.y
      @g.beginFill(0x000000)
      @g.drawCircle site.x, site.y, 3
      @g.endFill()
  
  drawCentroids: ->
    @g.lineStyle 2, 0x8888FF, 1

    for centroid in @diagram.centroids
      @g.moveTo centroid.x, centroid.y
      @g.beginFill(0x0000FF)
      @g.drawCircle centroid.x, centroid.y, 3
      @g.endFill()
  
  drawEdges: ->
    @g.lineStyle 2, 0xFF8888, 1
    
    for edge in @diagram.edges
      @g.moveTo edge.va.x, edge.va.y
      @g.lineTo edge.vb.x, edge.vb.y
    
  drawVertices: ->
    @g.lineStyle 2, 0xFF8888, 1

    for vertex in @diagram.vertices
      @g.beginFill(0xFF0000, 1)
      @g.moveTo vertex.x, vertex.y
      @g.drawCircle vertex.x, vertex.y, 3
      @g.endFill()
  
  fillCells: (color = 0x88FF88, alpha = 0.5) ->
    for cell in @diagram.cells
      @g.beginFill color, alpha
      @g.moveTo cell.halfedges[0].getStartpoint().x, cell.halfedges[0].getStartpoint().y
      
      for halfedge in cell.halfedges
        @g.lineTo halfedge.getEndpoint().x, halfedge.getEndpoint().y
      
      @g.endFill()