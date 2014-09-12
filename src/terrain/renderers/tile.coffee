class Terra.Terrain.TileRenderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    
  createTileMesh: ->
    g = new THREE.Geometry()
    
    TYPES = Terra.Terrain.DEFS
    
    ###
    # Render solid faces
    ###
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          terrain = TYPES[@chunk.data[x][y][z]]
          color = new THREE.Color terrain.color
          
          #skip rendering if this is not a solid
          if !terrain.solid
            continue
          
          #check for neighboring solids
          top = if @chunk.data[x]?[y + 1]?[z]? then TYPES[@chunk.data[x][y + 1][z]].solid else false
          bottom = if @chunk.data[x]?[y - 1]?[z]? then TYPES[@chunk.data[x][y - 1][z]].solid else false
          left = if @chunk.data[x - 1]?[y]?[z]? then TYPES[@chunk.data[x - 1][y][z]].solid else false
          right = if @chunk.data[x + 1]?[y]?[z]? then TYPES[@chunk.data[x + 1][y][z]].solid else false
          front = if @chunk.data[x]?[y]?[z + 1]? then TYPES[@chunk.data[x][y][z + 1]].solid else false
          back = if @chunk.data[x]?[y]?[z - 1]? then TYPES[@chunk.data[x][y][z - 1]].solid else false
          
          posHalfX = (x * @scaleX) + (0.5 * @scaleX)
          negHalfX = (x * @scaleX) - (0.5 * @scaleX)
          posHalfY = (y * @scaleY) + (0.5 * @scaleY)
          negHalfY = (y * @scaleY) - (0.5 * @scaleY)
          posHalfZ = (z * @scaleZ) + (0.5 * @scaleZ)
          negHalfZ = (z * @scaleZ) - (0.5 * @scaleZ)
          
          if !top
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
            
          if !bottom
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
          if !front
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
          
          if !back
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
          if !left
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+3, i+0, null, color
            
          
          if !right
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2, null, color
            g.faces.push new THREE.Face3 i+2, i+1, i+0, null, color
            
    
    g.computeFaceNormals()
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({vertexColors: THREE.FaceColors})
