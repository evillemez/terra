###
# Stores and creates the underlying data structure used to create the terrain mesh.
###
class Terra.Terrain.Chunk
  constructor: (maxX = 20, maxY = 10, maxZ = 20) ->
    @data = [[[]]]
    
    for x in [0 ... maxX]
      @data[x] ?= []
      for y in [0 ... maxY]
        @data[x][y] ?= []
        for z in [0 ... maxZ]
          @data[x][y][z] = @_getBlockType()
  
  _getBlockType: -> Math.round(Math.random())
