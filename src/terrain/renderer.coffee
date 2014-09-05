class Terra.Terrain.Renderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    
  createBoxesForSolids: ->
    meshes = []
    
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          
          if @chunk.data[x][y][z] == 0
            continue

          mesh = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.9, 0.9), new THREE.MeshLambertMaterial({color: 0xff8888}))
          mesh.position.x = x
          mesh.position.y = y
          mesh.position.z = z
          
          meshes.push mesh
    
    return meshes
  
  createMesh: ->
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
          
          halfX = x * 0.5 * @scaleX
          halfY = y * 0.5 * @scaleY
          halfZ = z * 0.5 * @scaleZ
          
          if !top
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 -halfX,  halfY, -halfZ
            g.vertices.push new THREE.Vector3 -halfX,  halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY, -halfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          if !bottom
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
            g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !front
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY,  halfZ
            g.vertices.push new THREE.Vector3 -halfX,  halfY,  halfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
          
          if !back
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
            g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY, -halfZ
            g.vertices.push new THREE.Vector3 -halfX,  halfY, -halfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
          if !left
            i = g.vertices.length
            g.vertices.push new THREE.Vector3 -halfX, -halfY, -halfZ
            g.vertices.push new THREE.Vector3 -halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3 -halfX,  halfY,  halfZ
            g.vertices.push new THREE.Vector3 -halfX,  halfY, -halfZ
            g.faces.push new THREE.Face3 i+0, i+1, i+2
            g.faces.push new THREE.Face3 i+2, i+3, i+0
            
          
          if !right
            i = g.vertices.length
            g.vertices.push new THREE.Vector3  halfX, -halfY, -halfZ
            g.vertices.push new THREE.Vector3  halfX, -halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY,  halfZ
            g.vertices.push new THREE.Vector3  halfX,  halfY, -halfZ
            g.faces.push new THREE.Face3 i+0, i+3, i+2
            g.faces.push new THREE.Face3 i+2, i+1, i+0
            
    
    g.computeFaceNormals()
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({color: 0xffffff})
  
  createScaledBoxMesh: (scaleX = 1, scaleY = 1, scaleZ = 1) ->
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
    
    return new THREE.Mesh g, new THREE.MeshLambertMaterial({color: 0xffffff})