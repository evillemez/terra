###
# Uses PIXI graphics objects to render a Terra.Voronoi.Diagram instance.
###
class Terra.Voronoi.Renderer
  constructor: (@stage, @diagram) ->
    @time = null
    @renderers = []
    
    @sitesRenderer = new PIXI.Graphics()
    stage.addChild @sitesRenderer
    @renderers.push @sitesRenderer
    
  render: ->
    renderer.clear() for renderer in @renderers
    startTime = Date.now()

    @renderSites()
    
    @time = Date.now() - startTime

  renderSites: ->
    g = @sitesRenderer
    
    if @diagram.sites.length
      for site in @diagram.sites
        g.moveTo site.x, site.y
        g.beginFill(0x000000)
        g.drawCircle site.x, site.y, 3
        g.endFill()
    