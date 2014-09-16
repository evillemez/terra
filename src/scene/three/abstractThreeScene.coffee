class Terra.Scene.ThreeScene extends Terra.Scene.AbstractScene
  constructor: ->

    #set up three.js scene & controls
    container = window.document.getElementById('container')
    @scene = new THREE.Scene()
    @camera = new THREE.PerspectiveCamera 75, container.clientWidth / container.clientHeight, 0.1, 1000
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize container.clientWidth, container.clientHeight
    container.appendChild @renderer.domElement
    @camera.position.z = 50
    @camera.position.y = 20
    @controls = new THREE.OrbitControls @camera
    @controls.damping = 0.2
  
    #add lights to scene
    @scene.add new THREE.AmbientLight 0x555555
    dirLight = new THREE.DirectionalLight 0xaaaaaa
    dirLight.position.set(50, 12, 50)
    @scene.add dirLight 

  run: ->
    render = =>
      requestAnimationFrame render
    
      @renderer.render @scene, @camera
  
    render()
    