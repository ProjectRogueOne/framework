{ theme } = require 'components/Theme'

MODEL = 'segment'

class exports.Sortable extends Layer
	constructor: ( options = {} ) ->
		
		# ---------------
		# Options

		_.defaults options,
			height: 48
			padding: 16
			animationOptions:
				time: .3

		@positions = options.positions ? throw 'Sortable needs a positions property (an empty array).'

		last = _.last(@positions)

		if last? 
			delete options.y
			delete options.midY
			delete options.maxY
			options.midY = last.midY + options.height + options.padding

		@customOptions = {}

		super options
		
		# ---------------
		# Layers
		
		# turn on draggable, but not horizontally
		_.assign @draggable,
			enabled: true
			horizontal: false
			propagateEvents: false
		
		# ---------------
		# Definitions

		# create a new item for this layer's position
		@position = 
			index: @positions.length
			layer: @
			midY: @midY
		
		# add it to the items array
		@positions.push(@position)
		
		Utils.defineValid @, 'theme', 'default', _.isString, "Button.theme must be a string.", @_setTheme
		Utils.define @, 'currentPosition', @position, @_takePosition

		# ---------------
		# Events
		
		@onDragStart ->
			@bringToFront()
			@theme = "dragging"

		@onDrag @_getNewPosition
				
		@onDragEnd -> 
			@_takePosition(@position)
			@theme = 'default'
	
	# ---------------
	# Private Methods

	_setTheme: (value) =>
		props = _.defaults _.clone(@customOptions), theme[MODEL][value]
		@animate props

	
	_getNewPosition: =>
		above = @positions[ @position.index + 1 ]
		below = @positions[ @position.index - 1 ]
		
		return if below?.midY < @midY < above?.midY

		if @midY > above?.midY
			above.layer.currentPosition = @position
			@_takePosition( above, false )
			
		else if @midY < below?.midY
			below.layer.currentPosition = @position
			@_takePosition( below, false )
	
	_takePosition: ( position, animate = true ) =>
		@position = position
		position.layer = @
		if animate 
			@animate { midY: position.midY }






