###
# ## About ##
# 
# This class generates a Voronoi diagram using the Bowyer-Watson algorithm.
# The way it is designed is not quite obvious at first glance.  Instantiating the
# the class will define all the computational steps required to generate the
# the diagram, but will not actually generate the diagram immediately.
#
# This allows you to compute only a certain number of steps at a time, which
# in turn allows you to use the `Terra.Voronoi.Renderer` class to visually
# render the Voronoi diagram while it is generating.
#
# Rendering is mainly for debugging purposes, as well as helping to understand
# how the algorithm works.
#
# ## Usage ##
#
# ```coffee
# pixiStage = #... create a pixi.js stage
# pixiRenderer = #... create a pixi.js renderer
#
# voronoi = new Terra.Voronoi.Diagram(800, 600, 50)
# voronoiRenderer = new Terra.Voronoi.Renderer(pixiStage, voronoi)
#
# #compute & render every thing at once:
# voronoi.compute()
# voronoiRenderer.render()
# pixiRenderer.render(pixiStage)
#
# #or render after every 20 steps while computing:
# renderSteps = (numSteps) ->
#   voronoi.computeSteps(numSteps)
#   voronoiRenderer.render()
#   pixiRenderer.render pixiStage
#
# renderSteps(20) while voronoi.hasRemainingSteps()
# ```
###
class Terra.Voronoi.Diagram
  
  ###
  # The constructor defines all the computational steps necessary
  # to generate the diagram, but does not actually trigger the generation.
  ###
  constructor: (@maxX, @maxY, @numSites, @relax = 0) ->
    @_reset()
  
  _reset: ->
    #public
    @cells = []
    @edges = []
    @vertices = []
    @sites = []
    @time = null
    
    #private
    @_steps = []            # computational steps for generating the diagram
    @_startTime = null      # time computation started
    @_triangles = []
    
    #define all the computational steps that will be required
    #to generate the voronoi diagram
    @_createSites()
    @_triangulate()
    
  ###
  # Creates site instances.
  ###
  _createSites: ->
    for i in [0...@numSites]
      @_steps.push =>
        @sites.push new Terra.Voronoi.Site(
          Math.floor(Math.random() * @maxX),
          Math.floor(Math.random() * @maxY)
        )
    
  ###
  # Use Bowyer-Watson algorithm to generate the Delaunay triangulation.
  ###
  _triangulate: ->
    triangles = []
    vertices = @vertices.splice 0
    triangles.push @_calculateBoundingTriangle()
    console.log 'hi'
    
    #determine supertriangle
    @_steps.push ->
      
   # determine the supertriangle
   # add supertriangle vertices to the end of the vertex list
   # add the supertriangle to the triangle list
   # for each sample point in the vertex list
   #    initialize the edge buffer
   #    for each triangle currently in the triangle list
   #       calculate the triangle circumcircle center and radius
   #       if the point lies in the triangle circumcircle then
   #          add the three triangle edges to the edge buffer
   #          remove the triangle from the triangle list
   #       endif
   #    endfor
   #    delete all doubly specified edges from the edge buffer
   #       this leaves the edges of the enclosing polygon only
   #    add to the triangle list all triangles formed between the point
   #       and the edges of the enclosing polygon
   # endfor
   # remove any triangles from the triangle list that use the supertriangle vertices
   # remove the supertriangle vertices from the vertex list
    
  ###
  # Calculate the bounding triangle for the given sites
  ###
  _calculateBoundingTriangle: ->
    
    
  ###
  # Compute the voronoi diagram all at once.
  ###
  compute: ->
    @_startTime = Date.now()
    
    #compute all steps at once
    @_steps.shift()() while @_steps.length > 0
    
    @time = Date.now() - @_startTime
  
  ###
  # Compute N number of steps of the diagram.  This is generally only useful if you want
  # to render the diagram during the process of computation.
  ###
  computeSteps: (num) ->
    for i in [0...num]
      steps.shift()()
  
  hasRemainingSteps: -> @_steps.length > 0
  
  ###
  # Lloyd relaxation algorithm to make the diagram less clumpy
  ###
  relax: (iterations) ->
    #TODO: implement
  
    