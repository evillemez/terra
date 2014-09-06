class Terra.Terrain.Renderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    
  createBoxesForSolids: ->
    meshes = []
    
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          
          if @chunk.data[x][y][z] == 0
            continue

          mesh = @createScaledBoxMesh 0.9, 0.9, 0.9, 0xffaa44
          mesh.position.x = x * @scaleX
          mesh.position.y = y * @scaleY
          mesh.position.z = z * @scaleZ
          
          meshes.push mesh
    
    return meshes
  
  createMesh: (color = 0x44aaff) ->
    g = new THREE.Geometry()
    
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          point = @chunk.data[x][y][z]
          
          #skip rendering if this is not a solid
          if point == 0
            continue
          
          #check for neighboring solids
          top = @chunk.data[x]?[y + 1]?[z]?
          bottom = @chunk.data[x]?[y - 1]?[z]?
          left = @chunk.data[x - 1]?[y]?[z]?
          right = @chunk.data[x + 1]?[y]?[z]?
          front = @chunk.data[x]?[y]?[z + 1]?
          back = @chunk.data[x]?[y]?[z - 1]?
          
          posHalfX = x + (0.5 * @scaleX)
          negHalfX = x - (0.5 * @scaleX)          
          posHalfY = y + (0.5 * @scaleY)
          negHalfY = y - (0.5 * @scaleY)
          posHalfZ = z + (0.5 * @scaleZ)
          negHalfZ = z - (0.5 * @scaleZ)
          
          if !top || top == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          if !bottom || bottom == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !front || front == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY,  posHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
          
          if !back || back == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !left || left == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3 negHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3 negHalfX,  posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          
          if !right || right == 0
            i = g.vertices.length
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY, negHalfZ
            g.vertices.push new THREE.Vector3  posHalfX, negHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY,  posHalfZ
            g.vertices.push new THREE.Vector3  posHalfX,  posHalfY, negHalfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
    
    g.computeFaceNormals()
    console.log vertex for vertex in g.vertices
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({color: color})
  
  createScaledBoxMesh: (scaleX = 1, scaleY = 1, scaleZ = 1, color = 0xffffff) ->
    g = new THREE.Geometry()
    halfX = scaleX * 0.5
    halfY = scaleY * 0.5
    halfZ = scaleZ * 0.5
    
    #add top
    i = g.vertices.length
    g.vertices.push new THREE.Vector3 -halfX, halfY, -halfZ
    g.vertices.push new THREE.Vector3 -halfX, halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX, halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX, halfY, -halfZ
    g.faces.push new THREE.Face3 i+0, i+1, i+2
    g.faces.push new THREE.Face3 i+2, i+3, i+0
    
    #add bottom
    i = g.vertices.length
    g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
    g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
    g.faces.push new THREE.Face3 i+0, i+3, i+2
    g.faces.push new THREE.Face3 i+2, i+1, i+0
    
    #add front
    i = g.vertices.length
    g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX,  halfY,  halfZ
    g.vertices.push new THREE.Vector3 -halfX,  halfY,  halfZ
    g.faces.push new THREE.Face3 i+0, i+1, i+2
    g.faces.push new THREE.Face3 i+2, i+3, i+0
    
    #add back
    i = g.vertices.length
    g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
    g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
    g.vertices.push new THREE.Vector3  halfX,  halfY, -halfZ
    g.vertices.push new THREE.Vector3 -halfX,  halfY, -halfZ
    g.faces.push new THREE.Face3 i+0, i+3, i+2
    g.faces.push new THREE.Face3 i+2, i+1, i+0

    #add left
    i = g.vertices.length
    g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
    g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3 -halfX,  halfY,  halfZ
    g.vertices.push new THREE.Vector3 -halfX,  halfY, -halfZ
    g.faces.push new THREE.Face3 i+0, i+1, i+2
    g.faces.push new THREE.Face3 i+2, i+3, i+0

    #add right
    i = g.vertices.length
    g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
    g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX,  halfY,  halfZ
    g.vertices.push new THREE.Vector3  halfX,  halfY, -halfZ
    g.faces.push new THREE.Face3 i+0, i+3, i+2
    g.faces.push new THREE.Face3 i+2, i+1, i+0
    
    g.computeFaceNormals();
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({color: color})