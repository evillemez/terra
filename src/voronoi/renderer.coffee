###
# Uses PIXI graphics objects to render a Terra.Voronoi.Diagram instance.
###
class Terra.Voronoi.Renderer
  constructor: (@stage, @diagram) ->
    @time = null
    @_graphics = {}
    
    for name in ['cells', 'edges', 'sites', 'vertices']
      @_graphics[name] = new PIXI.Graphics()
      stage.addChild @_graphics[name]
    
  draw: ->
    graphics.clear() for name, graphics of @_graphics

    startTime = Date.now()

    @fillCells()
    @drawEdges()
    @drawVertices()
    @drawSites()

    @time = Date.now() - startTime

  drawSites: ->
    g = @_graphics['sites']
    
    for site in @diagram.sites
      g.moveTo site.x, site.y
      g.beginFill(0x000000)
      g.drawCircle site.x, site.y, 3
      g.endFill()
  
  drawEdges: ->
    g = @_graphics['edges']
    g.lineStyle 2, 0xFF8888, 1
    
    for edge in @diagram.edges
      g.moveTo edge.va.x, edge.va.y
      g.lineTo edge.vb.x, edge.vb.y
    
  drawVertices: ->
    g = @_graphics['vertices']
    
    for vertex in @diagram.vertices
      g.moveTo vertex.x, vertex.y
      g.beginFill(0xFF0000)
      g.drawCircle vertex.x, vertex.y, 3
      g.endFill()
  
  fillCells: (color = 0x88FF88, alpha = 0.5) ->
    g = @_graphics['cells']
    
    for cell in @diagram.cells
      g.beginFill color, alpha
      g.moveTo cell.halfedges[0].getStartpoint().x, cell.halfedges[0].getStartpoint().y
      
      for halfedge in cell.halfedges
        g.lineTo halfedge.getEndpoint().x, halfedge.getEndpoint().y
      
      g.endFill()