###
# Stores and creates the underlying data structure used to create the terrain mesh.
###
class Terra.Terrain.RandomGenerator
  constructor: (maxX = 10, maxY = 2, maxZ = 10) ->
    @data = [[[]]]
    
    for x in [0 ... maxX]
      @data[x] ?= []
      for y in [0 ... maxY]
        @data[x][y] ?= []
        for z in [0 ... maxZ]
          @data[x][y][z] = @_getBlockType()
  
  #currently returns random 1 or 0
  _getBlockType: -> Math.round(Math.random())
