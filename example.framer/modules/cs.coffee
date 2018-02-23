framework = require "framework"
theme = framework.theme.theme

# -----------------
# myTheme - A Custom Theme for Framework

# This is an example "theme" for Framework. With themes, you can
# add new components and set style over-rides without modifying
# the base files, so that you can update Framework without losing
# your changes.



# -----------------
# Components

# To bring in your own components, require each of them
# and place the component's name (as a string) into
# the componentNames array.

{ Donut } = require 'cs-components/Donut'
{ Card } = require 'cs-components/Card'
# { Square } = require 'myTheme-components/Square'

componentNames = [
	'Card'
	'Donut'
#	'Square'
	]

# -----------------
# Fonts

Utils.insertCSS("""
 	@font-face {
		font-family: 'Aktiv Grotesk';
		font-weight: 200;
		src: url('modules/cs-components/fonts/AktivGrotesk_W_Hair.woff'); 
	}

	@font-face {
		font-family: 'Aktiv Grotesk';
		font-weight: 300;
		src: url('modules/cs-components/fonts/AktivGrotesk_W_Lt.woff'); 
	}

	@font-face {
		font-family: 'Aktiv Grotesk';
		font-weight: 400;
		src: url('modules/cs-components/fonts/AktivGrotesk_W_Rg.woff'); 
	}

	@font-face {
		font-family: 'Aktiv Grotesk';
		font-weight: 500;
		src: url('modules/cs-components/fonts/AktivGrotesk_W_Md.woff'); 
	}
""")


# -----------------
# Colors

# You can make changes to the default colors here.
# The colors you make will each get the "shade" treatment,
# so you'll be able to use colorName10, colorName20, etc as
# global variables. You can (and should!) use these colors
# in your custom components.

# You can change the value of the default colors (commented out
# in the list below), but you can't remove them.

themeColors =
	primary: '#0085dd'
	secondary: '#23c962'
	# black: '#252729'
	# grey: '#c1c1c2'
	# yellow: '#ffd16d'
	# white: '#FFF'
	# red: '#d96161'
	# beige: '#eae5e0'
	# blue: '#5399c3'
	# green: '#599FA0'




# -----------------
# Theme

# You can make changes to the default theme here.
# Check components/Theme for the defaults - but don't 
# change those defaults!

themeStyles = 
	typography: 
		Serif:
			fontFamily: 'Aktiv Grotesk'
		Sans:
			fontFamily: 'Aktiv Grotesk'
		H3:
			fontWeight: 300
			






# -----------------
# Blood-slick machinery
#
# Here's where your components get processed.
# Don't change this part!

framework.colors.updateColors(themeColors)
framework.theme.updateTheme(themeStyles)
framework.typography.updateTypography()

componentNames.forEach (componentName) =>
	window[componentName] = class FrameworkComponent extends eval(componentName)
		constructor: (options = {}) ->
			@app = framework.app
			super options