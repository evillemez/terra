###
# An x,y Voronoi site point
###
class Terra.Voronoi.Site #extends Terra.Voronoi.Vertex

  constructor: (@x, @y) ->
    @id = null
    @cell = null
    
    #one day, consider weighted sites
    @weight = 0
