class Terra.Terrain.Renderer
  constructor: (@chunk) ->
    
  createMesh: ->
    vertices = [
      new THREE.Vector3 0, 0, 0
      new THREE.Vector3 0, 1, 0
      new THREE.Vector3 0, 1, 1
    ]
    faces = [
      new THREE.Face3 0, 1, 2
    ]

    for x in [0...@chunk.data.length]
      for y in [0...@chunk.data[x].length]
        for z in [0...@chunk.data[x][y].length]
          console.log "(#{x},#{y},#{z}) = ", @chunk.data[x][y][z]
          
          top = @chunk.data[x]?[y + 1]?[z]?
          bottom = @chunk.data[x]?[y - 1]?[z]?
          left = @chunk.data[x - 1]?[y]?[z]?
          right = @chunk.data[x + 1]?[y]?[z]?
          front = @chunk.data[x]?[y]?[z]?
          back = @chunk.data[x]?[y]?[z + 1]?
          top = @chunk.data[x]?[y]?[z - 1]?
          
          # if top && top == 1
    
    #create mesh geometry with computed vertices and faces
    geometry = new THREE.Geometry()
    geometry.vertices.push vertex for vertex in vertices
    geometry.faces.push face for face in faces
    geometry.computeFaceNormals()
    
    return new THREE.Mesh geometry, new THREE.MeshLambertMaterial({color: 0xFF4444})