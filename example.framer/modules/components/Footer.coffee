Theme = require "components/Theme"
theme = undefined

class Footer extends Layer
	constructor: (options = {}) ->
		theme = Theme.theme

		_.defaults options,
			name: 'Footer'
			height: 44
			width: Screen.width
			clip: true
			shadowY: -1
			shadowColor: 'rgba(0,0,0,.16)'
			backgroundColor: if Utils.isChrome() then '#FFF' else 'rgba(255,255,255,.65)'
			backgroundBlur: 30

		_.assign @,
			tint: '#007AFF'
			offTint: '#C3C3C1'
			app: options.app

		super options

		@onTap (event) -> event.stopPropagation()

		@controls = new Layer
			name: '.'
			parent: @
			backgroundColor: null
			height: 28
			width: @width
			x: Align.center()
			y: Align.center()
			style:
				lineHeight: 0

		icons = ['back', 'forward', 'share', 'bookmark', 'tabs'].map (iconName) =>
			new SVGLayer
				name: iconName
				parent: @controls
				size: 28
				y: Align.center()
				backgroundColor: null
				fill: @tint
				svg: "<svg><path name='Rectangle' d='#{iconSVGs[iconName]}' />"

		icons[1].fill = @offTint

		Utils.distribute(icons, 'midX', 24, @width - 29)

		@backIcon = icons[0]
		
		# definitions

		Utils.define @, 'hasPrevious', false, @_setArrow

		# events
		
		@backIcon.onTap @_showPrevious

	_collapse: =>
		options = {time: .2}

		@animate
			y: Screen.height
			options: options

	_expand: =>
		options = {time: .2}

		@animate
			y: Align.bottom()
			options: options


	_setArrow: =>
		color = if @hasPrevious then @tint else @offTint
		@backIcon.fill = color

	_showPrevious: =>
		return if not @hasPrevious
		@app.showPrevious()

exports.Footer = Footer

iconSVGs =
	back: "M11.2198252,14.0179296 L18.4047812,21.3118426 C18.71163,21.6233446 18.7116442,22.123468 18.4048131,22.4349874 C18.1038965,22.740502 17.6122869,22.7442293 17.3067723,22.4433127 C17.3039918,22.4405741 17.301232,22.4378145 17.2984931,22.4350342 L10.1132808,15.1412665 L10.1102627,15.1443304 L9,14.0176583 L9.00319775,14.0144121 L9,14.011166 L10.1062726,12.8874904 L10.109773,12.8910439 L17.325584,5.56572841 C17.6275906,5.25913872 18.1209553,5.25542335 18.427545,5.55742991 C18.4302959,5.56013966 18.4330266,5.56286982 18.4357369,5.56562016 C18.7436533,5.87808756 18.7437023,6.37987304 18.4358467,6.69240048 L11.2198252,14.0179296 Z"
	forward: "M16.4468811,14.0179296 L9.23085958,6.69240048 C8.92300403,6.37987304 8.92305296,5.87808756 9.23096945,5.56562016 C9.23367974,5.56286982 9.23641043,5.56013966 9.2391613,5.55742991 C9.545751,5.25542335 10.0391157,5.25913872 10.3411223,5.56572841 L17.5569333,12.8910439 L17.5604337,12.8874904 L18.6667063,14.011166 L18.6635086,14.0144121 L18.6667063,14.0176583 L17.5564436,15.1443304 L17.5534255,15.1412665 L10.3682132,22.4350342 C10.3654743,22.4378145 10.3627145,22.4405741 10.359934,22.4433127 C10.0544194,22.7442293 9.56280982,22.740502 9.26189321,22.4349874 C8.95506208,22.123468 8.95507627,21.6233446 9.26192507,21.3118426 L16.4468811,14.0179296 Z"
	share: "M14.6666667,2.21999063 L14.6666667,17.1520468 L13.6666667,17.1520468 L13.6666667,2.2345679 L10.2126922,5.68854234 L9.33333333,4.83950617 L14.1728395,5.3e-15 L19,4.83950617 L18.1509638,5.68854234 L14.6666667,2.21999063 Z M22.6666667,9.15204678 L16.6666667,9.15204678 L16.6666667,8.15204678 L23.6666667,8.15204678 L23.6666667,27.1520468 L4.66666667,27.1520468 L4.66666667,8.15204678 L11.6666667,8.15204678 L11.6666667,9.15204678 L5.66666667,9.15204678 L5.66666667,26.1520468 L22.6666667,26.1520468 L22.6666667,9.15204678 Z"
	bookmark: "M20.3234128,2 C17.6948076,2 15.5002199,3.10675363 14.1671666,5.06420221 C12.8346133,3.10675363 10.6395255,2 8.01092038,2 C4.94679784,2 1.66666667,3.6398758 1.66666667,6.08093521 L1.66666667,24.4281398 C1.66666667,24.621184 1.77167087,24.7982246 1.94067762,24.8897456 C2.1101844,24.9802663 2.31619264,24.9712642 2.47469898,24.86524 C2.5152006,24.8382338 6.56036237,22.168622 9.82249283,22.168622 C11.9360773,22.168622 13.1896275,23.2843777 13.6566462,25.580904 C13.6596463,25.5964075 13.6691467,25.6094105 13.6736468,25.6244139 C13.6821472,25.6529205 13.6926476,25.6794265 13.7056481,25.7059326 C13.7206487,25.7359395 13.7371494,25.7629457 13.7571502,25.7889516 C13.7736508,25.8109567 13.7911515,25.8314614 13.8111523,25.8504657 C13.8351533,25.8739711 13.8611543,25.8934756 13.8896555,25.9114797 C13.9121564,25.925983 13.9341573,25.9404864 13.9596583,25.9509888 C13.9921596,25.9654921 14.0256609,25.9734939 14.0611623,25.9814958 C14.0796631,25.9854967 14.0956637,25.995499 14.1151645,25.9974994 C14.1321652,25.9989998 14.1491659,26 14.1666666,26 L14.1666666,26 L14.1671666,26 L14.1676666,26 L14.1681666,26 C14.1851673,26 14.202168,25.9984997 14.2196687,25.9974994 C14.2386694,25.995499 14.2546701,25.9859968 14.2731708,25.9814958 C14.3081722,25.9734939 14.3421736,25.9659922 14.3746749,25.9509888 C14.3996759,25.9399862 14.4216768,25.925983 14.4446777,25.9114797 C14.4731788,25.8934756 14.4991798,25.8739711 14.5231808,25.8504657 C14.5431816,25.8314614 14.5601823,25.8109567 14.5766829,25.7889516 C14.5966837,25.7629457 14.6131844,25.7359395 14.627685,25.7059326 C14.6406855,25.6794265 14.6511859,25.6529205 14.6596863,25.6244139 C14.6641864,25.6094105 14.6736868,25.5964075 14.6766869,25.580904 C15.1437056,23.2843777 16.3977558,22.168622 18.5108403,22.168622 C21.7734708,22.168622 25.8181325,24.8377336 25.8586341,24.86524 C26.0176405,24.9707641 26.2231487,24.9802663 26.3926555,24.8897456 C26.5616622,24.7982246 26.6666664,24.621184 26.6666664,24.4281398 L26.6666664,6.08093521 C26.6676665,3.6398758 23.3880353,2 20.3234128,2 L20.3234128,2 Z M9.8213181,20.9737117 C7.12198095,20.9737117 4.08874667,22.5146282 2.66666667,23.3333333 L2.66666667,6.01568004 C2.66666667,4.43745923 5.20860952,3 7.99946667,3 C10.5238095,3 12.5820038,4.1439987 13.6666667,6.14450424 L13.6666667,22.7339775 C12.8017524,21.5740623 11.504381,20.9737117 9.8213181,20.9737117 L9.8213181,20.9737117 Z M25.6666667,23.3333333 C24.2445867,22.5146082 21.2113524,20.973654 18.5120152,20.973654 C16.8289524,20.973654 15.531581,21.5740193 14.6666667,22.7339628 L14.6666667,6.14458116 C15.7513295,4.14402668 17.8100267,3 20.3338667,3 C23.1247238,3 25.6661638,4.43749439 25.6661638,6.01575381 L25.6661638,23.3333333 L25.6666667,23.3333333 Z"
	tabs: "M2.66666667,8.33333333 L2.66666667,25.6666667 L20,25.6666667 L20,8.33333333 L2.66666667,8.33333333 Z M1.66666667,7.33333333 L21,7.33333333 L21,26.6666667 L1.66666667,26.6666667 L1.66666667,7.33333333 Z M8.33333333,2.66666667 L8.33333333,6.33333333 L7.33333333,6.33333333 L7.33333333,1.66666667 L26.6666667,1.66666667 L26.6666667,21 L22,21 L22,20 L25.6666667,20 L25.6666667,2.66666667 L8.33333333,2.66666667 Z"


# back = """<svg width="#{Utils.px(27)}" height="#{Utils.px(27)}" viewBox="0 0 27 27" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="back" fill="#C3C3C1" fill-rule="nonzero"> <polygon id="back-button" points="8.54820638 13.0819643 8 13.6301707 8.54820638 14.1783771 18.3719186 24.0020893 19.4683313 22.9056765 9.64461914 13.0819643 9.64461914 14.1783771 19.7265834 4.09641276 18.6301707 3"></polygon> </g> </g> </svg>"""
# forward = """<svg width="#{Utils.px(27)}" height="#{Utils.px(27)}" viewBox="0 0 27 27" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="forward" fill="#C3C3C1" fill-rule="nonzero"> <polygon id="forward-button" points="18.0819643 14.1783771 18.0819643 13.0819643 8.25825212 22.9056765 9.35466488 24.0020893 19.1783771 14.1783771 19.7265834 13.6301707 19.1783771 13.0819643 9.09641276 3 8 4.09641276"></polygon> </g> </g> </svg>"""
# share = """<svg width="#{Utils.px(27)}" height="#{Utils.px(27)}" viewBox="0 0 27 27" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="share" fill="#007AFF"> <path d="M13.3033708,1.76453933 L10.050809,5.01710112 L9.31997753,4.28626966 L13.8202247,-0.213977528 L18.3204719,4.28626966 L17.5896404,5.01710112 L14.3370787,1.76453933 L14.3370787,17.8314607 L13.3033708,17.8314607 L13.3033708,1.76453933 Z M23.6476854,27.3932584 L4,27.3932584 L4,7.75280899 L11.2359551,7.75280899 L11.2359551,8.78651685 L5.03370787,8.78651685 L5.03370787,26.3595506 L22.6139775,26.3595506 L22.6139775,8.78651685 L16.4044944,8.78651685 L16.4044944,7.75280899 L23.6476854,7.75280899 L23.6476854,27.3932584 Z" id="share"></path> </g> </g> </svg>"""
# bookmark = """<svg width="#{Utils.px(27)}" height="#{Utils.px(27)}" viewBox="0 0 27 27" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="bookmark" fill="#007AFF"> <path d="M12.9213483,4.1011236 C12.9213483,2.95939326 11.9956629,2.03370787 10.8539326,2.03370787 L5.16853933,2.03370787 C5.08377528,2.03370787 5.00314607,2.04869663 4.92096629,2.05851685 C4.92768539,2.05076404 4.93285393,2.04146067 4.93957303,2.03370787 L2.58426966,2.03370787 C1.7278427,2.03370787 1.03370787,2.7278427 1.03370787,3.58426966 L1.03370787,20.1235955 C1.03370787,20.9800225 1.7278427,21.6741573 2.58426966,21.6741573 L10.8539326,21.6741573 C11.6482274,21.6741573 12.372723,21.9726932 12.9213483,22.4636939 L12.9213483,20.1235955 L12.9213483,4.1011236 Z M13.9550562,24.7752809 L13.9550562,25.2921348 L12.9213483,25.2921348 L12.9213483,24.7752809 C12.9213483,23.6335506 11.9956629,22.7078652 10.8539326,22.7078652 L2.58426966,22.7078652 C1.15723596,22.7078652 0,21.5511461 0,20.1235955 L0,3.58426966 C0,2.15723596 1.15723596,1 2.58426966,1 L10.8539326,1 C11.9326613,1 12.8826506,1.55062715 13.4382022,2.38618309 C13.9937539,1.55062715 14.9437432,1 16.0224719,1 L24.2921348,1 C25.7191685,1 26.8764045,2.15723596 26.8764045,3.58426966 L26.8764045,20.1235955 C26.8764045,21.5511461 25.7191685,22.7078652 24.2921348,22.7078652 L16.0224719,22.7078652 C14.8807416,22.7078652 13.9550562,23.6335506 13.9550562,24.7752809 Z M13.9550562,4.1011236 L13.9550562,20.1235955 L13.9550562,22.4636939 C14.5036815,21.9726932 15.2281771,21.6741573 16.0224719,21.6741573 L24.2921348,21.6741573 C25.1485618,21.6741573 25.8426966,20.9800225 25.8426966,20.1235955 L25.8426966,3.58426966 C25.8426966,2.7278427 25.1485618,2.03370787 24.2921348,2.03370787 L21.9368315,2.03370787 C21.9435506,2.04146067 21.9487191,2.05076404 21.9554382,2.05851685 C21.8732584,2.04869663 21.7926292,2.03370787 21.7078652,2.03370787 L16.0224719,2.03370787 C14.8807416,2.03370787 13.9550562,2.95939326 13.9550562,4.1011236 Z" id="bookmark"></path> </g> </g> </svg>"""
# tabs = """<svg width="#{Utils.px(27)}" height="#{Utils.px(27)}" viewBox="0 0 27 27" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="tabs" fill="#007AFF" fill-rule="nonzero"> <path d="M1,25.8089888 L1,26.3258427 L1.51685393,26.3258427 L20.1235955,26.3258427 L20.6404494,26.3258427 L20.6404494,25.8089888 L20.6404494,7.20224719 L20.6404494,6.68539326 L20.1235955,6.68539326 L1.51685393,6.68539326 L1,6.68539326 L1,7.20224719 L1,25.8089888 Z M1.51685393,7.71910112 L20.1235955,7.71910112 L19.6067416,7.20224719 L19.6067416,25.8089888 L20.1235955,25.2921348 L1.51685393,25.2921348 L2.03370787,25.8089888 L2.03370787,7.20224719 L1.51685393,7.71910112 Z M7.71910112,1.51685393 L7.71910112,5.65168539 L6.68539326,5.65168539 L6.68539326,1.51685393 L6.68539326,1 L7.20224719,1 L25.8089888,1 L26.3258427,1 L26.3258427,1.51685393 L26.3258427,20.1235955 L26.3258427,20.6404494 L25.8089888,20.6404494 L21.6741573,20.6404494 L21.6741573,19.6067416 L25.8089888,19.6067416 L25.2921348,20.1235955 L25.2921348,1.51685393 L25.8089888,2.03370787 L7.20224719,2.03370787 L7.71910112,1.51685393 Z" id="tabs"></path> </g> </g> </svg>"""