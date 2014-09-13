class Terra.Terrain.TileRenderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    
  createTileMesh: ->
    g = new THREE.Geometry()
    
    types = Terra.Terrain.TYPES
    defs = Terra.Terrain.DEFS
    
    ###
    # Render solid faces
    ###
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          
          terrain = defs[@chunk.data[x][y][z]]
          color = new THREE.Color terrain.color
          
          #skip rendering if this is not a solid
          if !terrain.solid
            continue
          
          #check for neighboring terrain - if none, assume air
          top = if @chunk.data[x]?[y + 1]?[z]? then defs[@chunk.data[x][y + 1][z]] else defs[types.AIR]
          bottom = if @chunk.data[x]?[y - 1]?[z]? then defs[@chunk.data[x][y - 1][z]] else defs[types.AIR]
          left = if @chunk.data[x - 1]?[y]?[z]? then defs[@chunk.data[x - 1][y][z]] else defs[types.AIR]
          right = if @chunk.data[x + 1]?[y]?[z]? then defs[@chunk.data[x + 1][y][z]] else defs[types.AIR]
          front = if @chunk.data[x]?[y]?[z + 1]? then defs[@chunk.data[x][y][z + 1]] else defs[types.AIR]
          back = if @chunk.data[x]?[y]?[z - 1]? then defs[@chunk.data[x][y][z - 1]] else defs[types.AIR]
          
          posHalfX = (x * @scaleX) + (0.5 * @scaleX)
          negHalfX = (x * @scaleX) - (0.5 * @scaleX)
          posHalfY = (y * @scaleY) + (0.5 * @scaleY)
          negHalfY = (y * @scaleY) - (0.5 * @scaleY)
          posHalfZ = (z * @scaleZ) + (0.5 * @scaleZ)
          negHalfZ = (z * @scaleZ) - (0.5 * @scaleZ)
          
          if !top.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
            
          if !bottom.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
          if !front.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
          
          if !back.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
          if !left.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
            
          
          if !right.solid
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
    
    g.computeFaceNormals()
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({vertexColors: THREE.FaceColors})
