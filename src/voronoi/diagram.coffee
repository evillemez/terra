Terra.Voronoi.Edge = Voronoi.Edge
Terra.Voronoi.Vertex = Voronoi.Vertex

class Terra.Voronoi.Diagram
  
  constructor: (maxX, maxY, numSites, relaxations = 0) ->
    @sites = @_createSites(maxX, maxY, numSites)

    voronoi = new Voronoi()
    boundingBox = { xl: 0, xr: maxX, yt: 0, yb: maxY }
    diagram = voronoi.compute(@sites, boundingBox)
    
    @cells = diagram.cells
    @edges = diagram.edges
    @vertices = diagram.vertices
    @time = diagram.execTime
    
    #associate cells and sites
    cell.site.cell = cell for cell in @cells
    
    @_calculateCellCentroids()
    
    #TODO: implement relaxation, and use voronoi.recycle
    if relaxations > 0
      console.log 'TODO: implement relaxation'
    
    #TODO: create delaunay triangulation from vornoi graph
  
  _createSites: (maxX, maxY, numSites) ->
    sites = []
    for i in [0...numSites]
      sites.push new Terra.Voronoi.Site(
        Math.floor(Math.random() * maxX),
        Math.floor(Math.random() * maxY), 
      )

    return sites
  
  #TODO
  _calculateCellCentroids: ->

  #TODO
  _calculateEdgeMidpoints: ->
      
  getCellAt: (x, y) ->
    #TODO: 