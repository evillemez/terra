class Terra.Terrain.PerlinHeightmapGenerator
  constructor: (@maxX, @maxY, @maxZ, frequency, type = 'simplex') ->
    @data = [[[]]]
    
    switch type
      when 'simplex' then perlin = new window.SimplexNoise()
      when 'classical' then perlin = new window.ClassicalNoise()
      else throw Error 'Must specify noise type, either "classical" or "simplex".'
    
    #create heightmap data
    heightmap = [[]]
    for x in [0...@maxX]
      heightmap[x] ?= []
      for z in [0...@maxZ]
        
        #I have no idea what I'm doing - but it seems to be working.
        noiseValue = perlin.noise(
          x * frequency * 1 / @maxX, 
          z * frequency * 1 / @maxZ, 
          0
        )
        
        #convert noise number to scale based on @maxY height
        heightValue = ((noiseValue - -1) / (1 - -1)) * (@maxY - 0) + 0
        
        heightmap[x][z] = Math.round(heightValue)
    
    #create chunk, choosing block based on height at given point
    types = Terra.Terrain.TYPES

    for x in [0 ... maxX]
      @data[x] ?= []
      for y in [0 ... maxY]
        @data[x][y] ?= []
        for z in [0 ... maxZ]
          height = heightmap[x][z]
          
          #assign terrain types based on height
          @data[x][y][z] = switch
            when y == 0 then          types.BEDROCK
            when y > height then      types.AIR
            when y == height then     types.GRASS
            else                      types.DIRT
