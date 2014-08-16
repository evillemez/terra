# Voronoi Diagram #

Wraps Raymond Hill's implementation of a Voronoi diagram here: https://github.com/gorhill/Javascript-Voronoi.

## Usage ##

```coffee
pixiStage = #... create a pixi.js stage
pixiRenderer = #... create a pixi.js renderer

voronoi = new Terra.Voronoi.Diagram(800, 600, 50)
voronoiRenderer = new Terra.Voronoi.Renderer(pixiStage, voronoi)

voronoiRenderer.draw()
pixiRenderer.render(pixiStage)
```
