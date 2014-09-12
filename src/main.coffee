#app namespaces
Terra =
  Scene: {}
  Voronoi: {}
  Event: {}
  Terrain: {}

#do stuff once DOM loads
document.addEventListener 'DOMContentLoaded', ->
  
  name = 'terrain'
  
  switch name
    when 'terrain' then scene = new Terra.Scene.Terrain()
    when 'voronoi' then scene = new Terra.Scene.Voronoi()
  
  scene.run()
