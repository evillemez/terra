###
# Terrain unit type definitions... this likely won't scale up well, depending on
# how many types there end up being.
###
Terra.Terrain.TYPES =
  AIR: 0
  BEDROCK: 1
  DIRT: 2
  GRASS: 3
  WATER: 4

Terra.Terrain.DEFS = [
    name: 'air'
    color: 0xaaaaff
    solid: false
  ,
    name: 'bedrock'
    color: 0x444444
    solid: true
  ,
    name: 'dirt'
    color: 0xff8844
    solid: true
  ,
    name: 'grass'
    color: 0x44cc77
    solid: true
  ,
    name: 'water'
    color: 0xbbbbff
    solid: false
]
