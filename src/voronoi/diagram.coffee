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
    
    @centroids = []
    
    #associate cells and sites
    cell.site.cell = cell for cell in @cells
    
    @_calculateCellCentroids()
    
    #TODO: implement relaxation, and use voronoi.recycle
    if relaxations > 0
      console.log 'TODO: implement relaxation'
    
    #TODO: create delaunay triangulation from vornoi graph
  
  _createSites: (maxX, maxY, numSites) ->
    sites = []
    
    interval = 50
    variation = 8
    
    for x in [(interval * 0.5)...maxX] by interval
      for y in [(interval * 0.5)...maxY] by interval
        sites.push new Terra.Voronoi.Site(
          Math.floor(Math.random() * ((x + variation) - (x - variation))) + (x - variation)
          Math.floor(Math.random() * ((y + variation) - (y - variation))) + (y - variation)
        )
    
    return sites
  
  #TODO - do this for real, currently it is just averaging points, which
  #is incorrect
  _calculateCellCentroids: ->
    for cell in @cells
      sumX = 0
      sumY = 0

      for halfedge in cell.halfedges
        point = halfedge.getStartpoint()
        sumX += point.x
        sumY += point.y
      
      cell.centroid = centroid = { x: sumX / cell.halfedges.length, y: sumY / cell.halfedges.length }
      centroid.cell = cell
      @centroids.push centroid

  #TODO
  _calculateEdgeMidpoints: ->
      
  getCellAt: (x, y) ->
    #TODO: 