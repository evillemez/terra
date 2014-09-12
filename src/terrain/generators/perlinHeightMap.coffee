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
        heightmap[x][z] = Math.round(Math.abs(perlin.noise(
          x * frequency * 1 / @maxX, 
          z * frequency * 1 / @maxZ, 
          0
        )) * 10)

    
    #create chunk, choosing block based on height at given point
    for x in [0 ... maxX]
      @data[x] ?= []
      for y in [0 ... maxY]
        @data[x][y] ?= []
        for z in [0 ... maxZ]
          height = heightmap[x][z]
          @data[x][y][z] = if y <= height then 1 else 0
    