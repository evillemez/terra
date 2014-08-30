class Terra.Terrain.Renderer
  constructor: (@chunk, @scale) ->
  
  createBoxesForSolids: ->
    meshes = []
    
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          
          if @chunk.data[x][y][z] == 1
            mesh = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.9, 0.9), new THREE.MeshLambertMaterial({color: 0xff8888}))
            mesh.position.x = x
            mesh.position.y = y
            mesh.position.z = z
            
            meshes.push mesh
    
    return meshes
  
  createMesh: ->
    vertices = []
    faces = []

    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          point = @chunk.data[x][y][z]
          
          continue if point == 1
          
          pos = [x, y, z]
          
          top = @chunk.data[x]?[y + 1]?[z]?
          bottom = @chunk.data[x]?[y - 1]?[z]?
          left = @chunk.data[x - 1]?[y]?[z]?
          right = @chunk.data[x + 1]?[y]?[z]?
          front = @chunk.data[x]?[y]?[z - 1]?
          back = @chunk.data[x]?[y]?[z + 1]?
          
          @_addTop vertices, faces    if top == 0
          @_addBottom vertices, faces if bottom == 0
          @_addLeft vertices, faces   if left == 0
          @_addRight vertices, faces  if right == 0
          @_addFront vertices, faces  if front == 0
          @_addBack vertices, faces   if back == 0
    
    #create mesh geometry with computed vertices and faces
    geometry = new THREE.Geometry()
    geometry.vertices.push vertex for vertex in vertices
    geometry.faces.push face for face in faces
    geometry.computeFaceNormals()
    
    return new THREE.Mesh geometry, new THREE.MeshLambertMaterial({color: 0xffffff})
  
  _addTop: (vertices, faces, point) -> console.log 'adding top'
  _addBottom: (vertices, faces, point) -> console.log 'adding bottom'
  _addLeft: (vertices, faces, point) -> console.log 'adding left'
  _addRight: (vertices, faces, point) -> console.log 'adding right'
  _addFront: (vertices, faces, point) -> console.log 'adding front'
  _addBack: (vertices, faces, point) -> console.log 'adding back'
  