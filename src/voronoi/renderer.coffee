###
# Uses PIXI graphics objects to render a Terra.Voronoi.Diagram instance.
###
class Terra.Voronoi.Renderer
  constructor: (@stage, @diagram) ->
    @time = null
    @_graphics = {}
    
    @_graphics['sites'] = new PIXI.Graphics()
    stage.addChild @_graphics['sites']
    
    @_graphics['edges'] = new PIXI.Graphics()
    stage.addChild @_graphics['edges']

    @_graphics['vertices'] = new PIXI.Graphics()
    stage.addChild @_graphics['vertices']
    
  draw: ->
    graphics.clear() for name, graphics of @_graphics

    startTime = Date.now()
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
