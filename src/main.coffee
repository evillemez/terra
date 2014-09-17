#app namespaces
Terra =
  Scene: {}
  Voronoi: {}
  Event: {}
  Terrain: {}

shader = (name) -> document.getElementById(name).textContent

#do stuff once DOM loads
document.addEventListener 'DOMContentLoaded', ->
  
  sceneToLoad = 'terrain'
  
  scene = switch
    when 'terrain' == sceneToLoad then new Terra.Scene.Terrain()
    when 'voronoi' == sceneToLoad then new Terra.Scene.Voronoi()
  
  scene.setup()
  scene.run()
