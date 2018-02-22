framework = require 'framework'

# New Components

{ Donut } = require 'cs-components/Donut'
{ Card } = require 'cs-components/Card'

[
	'Donut'
	'Card'
	].forEach (componentName) ->

	c = eval(componentName)
	window[componentName] = class FrameworkComponent extends c 
		constructor: (options = {}) ->
			@constructorName = componentName

			_.assign(options, {app: framework.app})

			super options