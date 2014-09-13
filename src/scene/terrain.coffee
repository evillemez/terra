###
# Create and render a 3D terrain chunk.
###
class Terra.Scene.Terrain
  constructor: ->
    @name = 'Terrain Demo'
  
  run: ->
    #set up three.js scene & controls
    container = document.getElementById('container')
    scene = new THREE.Scene()
    camera = new THREE.PerspectiveCamera 75, container.clientWidth / container.clientHeight, 0.1, 1000
    renderer = new THREE.WebGLRenderer()
    renderer.setSize container.clientWidth, container.clientHeight
    container.appendChild renderer.domElement
    camera.position.z = 50
    camera.position.y = 20
    controls = new THREE.OrbitControls camera
    controls.damping = 0.2
  
    #add lights to scene
    scene.add new THREE.AmbientLight 0x555555
    dirLight = new THREE.DirectionalLight 0xaaaaaa
    dirLight.position.set(50, 12, 50)
    scene.add dirLight 
  
    #create & add terrain
    chunk = new Terra.Terrain.PerlinHeightmapGenerator(50, 40, 50, 0.75, 'simplex')
    chunkRenderer = new Terra.Terrain.TileRenderer chunk, 1, 0.5, 1    
    time = Date.now()
    mesh = chunkRenderer.createTileMesh()
    mesh.position.x -= 20
    mesh.position.z -= 20
    scene.add mesh
    
    #render scene
    render = ->
      requestAnimationFrame render
    
      renderer.render scene, camera
  
    render()
    