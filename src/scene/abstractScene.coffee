class Terra.Scene.AbstractScene
  setup: -> throw new Error 'Must be implemented by extending scene.'
    
  run: -> throw new Error 'Must be implemented by extending scene.'