#app namespaces
Terra =
  Voronoi: {}
  Event: {}
  Terrain: {}

###
# Create and render a Voronoi diagram.
###
voronoi = ->
  #setup pixi.js stage
  @container = document.getElementById('container')
  @height = container.clientHeight
  @width = container.clientWidth
  @stage = new PIXI.Stage(0xFFFFFF)
  @renderer = PIXI.autoDetectRenderer width, height
  @container.appendChild renderer.view
  
  #build and display voronoi graph
  @voronoi = new Terra.Voronoi.Diagram(width, height, 50)
  console.log "Voronoi computed in #{voronoi.time} ms."

  @voronoiRenderer = new Terra.Voronoi.Renderer(stage, voronoi)
  @voronoiRenderer.draw()
  console.log "Voronoi rendered in #{voronoiRenderer.time} ms."
    
  #render the scene
  @renderer.render stage  

###
# Create and render a 3D terrain chunk.
###
terrain = ->
  #setup three.js scene
  @container = document.getElementById('container')
  @scene = new THREE.Scene()
  @camera = new THREE.PerspectiveCamera 75, @container.clientWidth / @container.clientHeight, 0.1, 1000
  @renderer = new THREE.WebGLRenderer()
  @renderer.setSize @container.clientWidth, @container.clientHeight
  @container.appendChild @renderer.domElement
  @camera.position.z = 50
  @camera.position.y = 20
  @controls = new THREE.OrbitControls @camera
  @controls.damping = 0.2
  
  #add lights to scene
  dirLight = new THREE.DirectionalLight 0xffffff
  dirLight.position.set(1, 1, 10).normalize()
  ambLight = new THREE.AmbientLight 0x555555
  @scene.add ambLight
  @scene.add dirLight 
  
  ###
  # Experiments...
  ###
  @chunk = new Terra.Terrain.RandomGenerator(30, 10, 30)
  @chunkRenderer = new Terra.Terrain.TileRenderer @chunk, 1, 0.5, 1

  # #computed data mesh
  time = Date.now()
  mesh = chunkRenderer.createTileMesh()
  mesh.position.x -= 15
  console.log "Mesh computed in #{Date.now() - time}"
  @scene.add mesh
    
  #render scene
  render = =>
    requestAnimationFrame render
    
    @renderer.render @scene, @camera
  
  render()

#do stuff once DOM loads
document.addEventListener 'DOMContentLoaded', terrain.bind window
