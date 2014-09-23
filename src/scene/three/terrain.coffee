###
# Create and render a 3D terrain chunk.
###
class Terra.Scene.Terrain extends Terra.Scene.ThreeScene
  setup: ->  

    #create terrain mesh
    chunk = new Terra.Terrain.PerlinHeightmapGenerator(50, 30, 50, 1, 'simplex')
    time = Date.now()
    chunkGeometry = new Terra.Terrain.TileGeometry chunk, 1, 0.33, 1
    chunkGeometry.computeFaceNormals()
    chunkMaterial = new THREE.MeshLambertMaterial({vertexColors: THREE.FaceColors})
    # chunkMaterial = new THREE.ShaderMaterial({
    #   vertexShader: shader 'simpleVertex'
    #   fragmentShader: shader 'simpleFragment'
    # })
    mesh = new THREE.Mesh(chunkGeometry, chunkMaterial)
    
    #add to scene
    mesh.position.x -= 20
    mesh.position.z -= 20
    @scene.add mesh
    
