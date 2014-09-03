class Terra.Terrain.Renderer
  constructor: (@chunk, @scaleX = 1, @scaleY = 1, @scaleZ = 1) ->
    @_geometry = new THREE.Geometry()
    
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
    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          point = @chunk.data[x][y][z]
          
          if point == 0
            continue
          
          pos = [x, y, z]
          
          top = @chunk.data[x]?[y + 1]?[z]?
          bottom = @chunk.data[x]?[y - 1]?[z]?
          left = @chunk.data[x - 1]?[y]?[z]?
          right = @chunk.data[x + 1]?[y]?[z]?
          front = @chunk.data[x]?[y]?[z + 1]?
          back = @chunk.data[x]?[y]?[z - 1]?
          
          @_addTop pos    if top
          @_addBottom pos if bottom
          @_addLeft pos   if left
          @_addRight pos  if right
          @_addFront pos  if front
          @_addBack pos   if back
    
    #what does this -actually- do? seemed to flip my normals, which I so lovingly crafted
    @_geometry.computeFaceNormals()
    @_geometry.computeVertexNormals()
    
    return new THREE.Mesh @_geometry, new THREE.MeshLambertMaterial({color: 0xffffff})
  
  _addTop: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length
    
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 3, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 1, vertIndex)
    
  _addBottom: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length
    
    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 1, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 3, vertIndex)

  _addLeft: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length

    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, -halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 1, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 3, vertIndex)
    
  _addRight: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length

    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, -halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 3, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 1, vertIndex)
    
  _addFront: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length

    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 1, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 3, vertIndex)
    
  _addBack: (point) ->
    halfX = point[0] * 0.5 * @scaleX
    halfY = point[1] * 0.5 * @scaleY
    halfZ = point[2] * 0.5 * @scaleZ
    vertIndex = @_geometry.vertices.length

    @_geometry.vertices.push new THREE.Vector3(halfX, halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(-halfX, -halfY, -halfZ)
    @_geometry.vertices.push new THREE.Vector3(halfX, -halfY, -halfZ)

    @_geometry.faces.push new THREE.Face3(vertIndex, vertIndex + 3, vertIndex + 2)
    @_geometry.faces.push new THREE.Face3(vertIndex + 2, vertIndex + 1, vertIndex)
  