class Terra.Terrain.TileRenderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    
  createTileMesh: (color = 0x44aaff) ->
    g = new THREE.Geometry()
    
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          point = @chunk.data[x][y][z]
          
          #skip rendering if this is not a solid
          if point == 0
            continue
          
          #check for neighboring solids
          top = if @chunk.data[x]?[y + 1]?[z]? then !!@chunk.data[x][y + 1][z] else false
          bottom = if @chunk.data[x]?[y - 1]?[z]? then !!@chunk.data[x][y - 1][z] else false
          left = if @chunk.data[x - 1]?[y]?[z]? then !!@chunk.data[x - 1][y][z] else false
          right = if @chunk.data[x + 1]?[y]?[z]? then !!@chunk.data[x + 1][y][z] else false
          front = if @chunk.data[x]?[y]?[z + 1]? then !!@chunk.data[x][y][z + 1] else false
          back = if @chunk.data[x]?[y]?[z - 1]? then !!@chunk.data[x][y][z - 1] else false
          
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
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          if !bottom
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !front
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
          
          if !back
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !left
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          
          if !right
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, negHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, posHalfZ
            g.vertices.push new THREE.Vector3 posHalfX, posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
    
    g.computeFaceNormals()
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({color: color})
