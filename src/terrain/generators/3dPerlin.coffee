class Terra.Terrain.Perlin3dGenerator
  constructor: (@maxX, @maxY, @maxZ, frequency, type = 'simplex') ->
    @data = [[[]]]
    
    switch type
      when 'simplex'
        perlin = new window.SimplexNoise()
        noise = perlin.noise3d.bind perlin
      when 'classical'
        perlin = new window.ClassicalNoise()
        noise = perlin.noise.bind perlin
      else throw Error 'Must specify noise type, either "classical" or "simplex".'
        
    #create map of solids
    solidMap = [[[]]]
    for x in [0...@maxX]
      solidMap[x] ?= []
      for y in [0...@maxY]
        solidMap[x][y] ?= []
        for z in [0...@maxZ]
        
          #I have no idea what I'm doing - but it seems to be working.
          noiseValue = noise(
            x * frequency * 1 / @maxX,
            y * frequency * 1 / @maxY,
            z * frequency * 1 / @maxZ
          )
        
          solidMap[x][y][z] = Math.round(noiseValue)
    
    #Choose block type for each solid point
    for x in [0 ... maxX]
      @data[x] ?= []
      for y in [0 ... maxY]
        @data[x][y] ?= []
        for z in [0 ... maxZ]
          @data[x][y][z] = @_getBlockType(x, y, z, solidMap)
          
  _getBlockType: (x, y, z, map) ->
    types = Terra.Terrain.TYPES
    solid = !!map[x][y][z]
    
    #bedrock always on bottom
    return types.BEDROCK if y == 0
    
    #air is 0
    return types.AIR if !solid
    
    #otherwise, it's solid... let's play
    
    #grass if this point is solid, but air above
    return types.GRASS if (map[x]?[y + 1]?[z]? && !!!map[x][y + 1][z])
    
    #otherwise, just dirt for now
    return types.DIRT