###
# Experiment to generate a heightmap first, but then merge the final data set with another
# 3d perlin dataset.
###
class Terra.Terrain.PerlinCombinedGenerator extends Terra.Terrain.Perlin2dGenerator
  constructor: (@maxX, @maxY, @maxZ, frequency, type = 'simplex') ->
    #initialize as normal heightmap
    super(@maxX, @maxY, @maxZ, frequency, type = 'simplex')
    
    #and generate a new 3d set
    perlin3d = new Terra.Terrain.Perlin3dGenerator(@maxX, @maxY, @maxZ, frequency / 2, type)
    
    types = Terra.Terrain.TYPES
    
    #if the heightmap is air - replace it with the type in the 3d version
    for x in [0...@maxX]
      for y in [0...@maxY]
        for z in [0...@maxZ]
          if @data[x][y][z] == types.AIR
            @data[x][y][z] = if perlin3d.data[x][y][z] == types.AIR then types.AIR else types.STONE