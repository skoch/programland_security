$(document).ready(
	function()
	{
		var _users;
		var _testSquare;
		var _boxWidth = 245;
		var _boxHeight = 50;
		var _iterations = 0;
		var _inCount = 0;
		var _usersToAnimateIn = 0;
		var _interval;
		var _running = false;

		var _codersList 	= [];
		var _coreList		= [];
		var _producersList	= [];
		var _designersList	= [];
		var _strategyList	= [];
		var _squidsList		= [];
		var _bearsList		= [];
		var _cheapiesList	= [];
		var _stephaniesList	= [];
		var _robotsList		= [];
		var _milkshakeList	= [];
		var _noTeamList		= [];
		
		// hate this method -- keep a list of everyone NOT in this group
		// so we can just target this instead of all users and singling out, etc
		var _codersAntiList 	= [];
		var _coreAntiList		= [];
		var _producersAntiList	= [];
		var _designersAntiList	= [];
		var _strategyAntiList	= [];
		var _squidsAntiList		= [];
		var _bearsAntiList		= [];
		var _cheapiesAntiList	= [];
		var _stephaniesAntiList	= [];
		var _robotsAntiList		= [];
		var _milkshakeAntiList	= [];
		var _noTeamAntiList		= [];

		var _allLists			= [];
		
		var _colors = ['#339900', '#006699', '#FFCC00', '#FF9900', '#CC0033'];
		var _statuses = ["Free", "A Little Workload", "Pretty Crazy", "Insane", "Leave Me the Fuck Alone" ];
		
		init();

		function init()
		{
			_setBrowser();

			setTimeout( function(){ window.scrollTo( 0, 1 ); }, 100 );

			_addMouseOver( $( '.btn' ) );
			$( '.btn' ).click( _btnClickHandler );
			// var a = [{'full_name': 'Able Parris'},{'full_name': 'Stephen Koch'},{'full_name': 'Zelda Jones'},{'full_name': 'Xavier Humphrey'}];
			// a.sort( _sortOnUserLastName );
			// console.log( a );
			// _testSquare = _createSquare( 10, 10, _boxWidth, _boxHeight, _colors[0] );
			// console.log('1', project.activeLayer)
			$.getJSON( 'includes/php/getStatus.php?rt=json', _setStaff );
		};

		function _setStaff( $data )
		{
			_users = $data.users;
			_users.sort( _sortOnUserLastName );
			// console.log( _users );

			_allLists = [
				// {'list': _users, 'anti': [], 'name': "Big Spaceship", 'id': 'all', 'filter': '.'},
				{'list': _coreList, 'anti': _coreAntiList, 'name': "Core", 'id': 'core', 'filter': '.core'},
				{'list': _codersList, 'anti': _codersAntiList, 'name': "Coders", 'id': 'coders', 'filter': '.technology'},
				{'list': _producersList, 'anti': _producersAntiList, 'name': "Producers", 'id': 'producers', 'filter': '.producers'},
				{'list': _designersList, 'anti': _designersAntiList, 'name': "Designers", 'id': 'designers', 'filter': '.designers'},
				{'list': _strategyList, 'anti': _strategyAntiList, 'name': "Strategy", 'id': 'strategy', 'filter': '.strategy'},
				{'list': _squidsList, 'anti': _squidsAntiList, 'name': "Squid Republic", 'id': 'squids', 'filter': '.squids'},
				{'list': _bearsList, 'anti': _bearsAntiList, 'name': "The Special Bears", 'id': 'bears', 'filter': '.bears'},
				{'list': _cheapiesList, 'anti': _cheapiesAntiList, 'name': "Cheapies Playhaus", 'id': 'cheapies', 'filter': '.cheapies'},
				{'list': _stephaniesList, 'anti': _stephaniesAntiList, 'name': "The Stephanies", 'id': 'stephanies', 'filter': '.stephanies'},
				{'list': _robotsList, 'anti': _robotsAntiList, 'name': "y [it's spanish]", 'id': 'robots', 'filter': '.robots'},
				{'list': _milkshakeList, 'anti': _milkshakeAntiList, 'name': "Milkshake Enterprise", 'id': 'milkshake', 'filter': '.milkshake'}
				// {'list': _noTeamList, 'anti': _noTeamAntiList, 'name': "Unassigned!", 'id': 'none', 'filter': '.'},
			];

			var items = [];
			// var _running_height = 0;
			for( var i = 0; i < _users.length; i++ )
			{
				_users[i].status = Math.round( Math.random() * 4 );
				// console.log( _users[i] );

				// grab the filters for isotope
				var filters = _users[i].discipline;
				for( var ii = _allLists.length - 1; ii >= 0; ii-- )
				{
					if( _users[i].team != 'Core' && _allLists[ii].name == _users[i].team )
					{
						filters += ' ' + _allLists[ii].id;
						break;
					}
				}

				filters +=  ' status-' + _users[i].status;

				// console.log( _users[i].full_name, filters );

				var x = ( ( _boxWidth ) + 10 ) * ( i % 5 );
				var y = ( ( _boxHeight ) + 10 ) * parseInt( i / 5 );
				var name = _users[i].full_name;
				if( jQuery.browser.iphone )
				{
					var pieces = _users[i].full_name.split( ' ' );
					name = pieces[0].charAt( 0 ) + '. ' + pieces[pieces.length - 1];
				}
				$( '#users' ).append( '<div class="user ' + filters + '" id="user-' + i + '" data-filter=".status-' + _users[i].status + '"><p>' + name + '</p></div>' );
				// $( '#user-' + i ).css( {left: Number( x ), top: Number( y ), backgroundColor: _colors[_users[i].status]} );
				$( '#user-' + i ).css( {backgroundColor: _colors[_users[i].status]} );

				// $( '#user-' + i ).click( _userClickHandler );

				// _running_height += ( x == 0 ) ? _boxHeight + 10 : 0;
				_users[i].id = i;
				
				// push everyone in this discipline to this list otherwise put them in the other list
				if( _users[i].discipline.indexOf( "technology" ) != -1 ) _codersList.push( _users[i] );
				else _codersAntiList.push( _users[i] );
				if( _users[i].discipline.indexOf( "core" ) != -1 ) _coreList.push( _users[i] );
				else _coreAntiList.push( _users[i] );
				if( _users[i].discipline.indexOf( "producers" ) != -1 ) _producersList.push( _users[i] );
				else _producersAntiList.push( _users[i] );
				if( _users[i].discipline.indexOf( "designers" ) != -1 ) _designersList.push( _users[i] );
				else _designersAntiList.push( _users[i] );
				if( _users[i].discipline.indexOf( "strategy" ) != -1 ) _strategyList.push( _users[i] );
				else _strategyAntiList.push( _users[i] );

				if( _users[i].team.indexOf( "Squid" ) != -1 ) _squidsList.push( _users[i] );
				else _squidsAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "Bears" ) != -1 ) _bearsList.push( _users[i] );
				else _bearsAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "Cheapies" ) != -1 ) _cheapiesList.push( _users[i] );
				else _cheapiesAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "Stephanies" ) != -1 ) _stephaniesList.push( _users[i] );
				else _stephaniesAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "Robot" ) != -1 ) _robotsList.push( _users[i] );
				else _robotsAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "NO" ) != -1 ) _noTeamList.push( _users[i] );
				else _noTeamAntiList.push( _users[i] );
				if( _users[i].team.indexOf( "Milkshake" ) != -1 ) _milkshakeList.push( _users[i] );
				else _milkshakeAntiList.push( _users[i] );

				/*
					discipline: "designers"
					email: "a.parris@bigspaceship.com"
					full_name: "Able Parris"
					password: "asdzxc;"
					status: "0"
					team: "Milkshake Enterprise"
					title: "Sr. Designer"
				*/

			}

			// $( '.user' ).click( _userClickHandler );
			$( '.color' ).click( _colorClickHandler );

			$( '#nav' ).isotope({
				itemSelector: '.btn',
				layoutMode: 'fitRows',
				animationEngine : 'best-available'
			});

			$( '#users' ).isotope({
				itemSelector: '.user',
				layoutMode: 'fitRows',
				animationEngine : 'best-available'
			});

			// $( '#users' ).css( 'height', _running_height );

			// $( '#top-bar' ).animate(
			// 	{ opacity: 1 },
			// 	{
			// 		duration: 500,
			// 		specialEasing: { opacity: 'easeInSine' }, 
			// 		complete: function()
			// 		{
			// 		}
			// 	}
			// );
			$( '#container' ).animate(
				{ opacity: 1 },
				{
					duration: 500,
					specialEasing: { opacity: 'easeInSine' }, 
					complete: function()
					{
					}
				}
			);

			if( jQuery.browser.iphone )
			{
				_onChangeView();
			}else
			{
				_startShow();
			}
			
			// _onChangeView();
			// $( '#users' ).isotope({ filter: '.technology' });
			// _setActiveButtonByID( 'coders' );
		};

		function _onChangeView()
		{
			var i = _iterations++ % _allLists.length;

			_setGroupName( _allLists[i].name );
			_setActiveButtonByID( _allLists[i].id );
			var selector = _allLists[i].filter;
			$( '#users' ).isotope({ filter: selector });

			// _animateUsersIn( _allLists[i].list );
			// _setGroupName( _allLists[i].name );
			// _setActiveButtonByID( _allLists[i].id );
			// _animateUsersOut( _allLists[i].anti );
		};

		function _setGroupName( $name )
		{
			$( '#group-name' ).animate(
				{ opacity: 0 },
				{
					duration: 500,
					specialEasing: { opacity: 'easeInSine' }, 
					complete: function()
					{
						$( this ).html( $name );
						$( '#group-name' ).animate(
							{ opacity: 1 },
							{
								duration: 500,
								specialEasing: { opacity: 'easeInSine' }, 
								complete: function()
								{
								}
							}
						);
					}
				}
			);
		};

		function _setActiveButtonByID( $id )
		{
			for( var i = _allLists.length - 1; i >= 0; i-- )
			{
				$( '#' + _allLists[i].id ).css( 'background-color', '' );
				$( '#' + _allLists[i].id ).removeClass( 'active' );
			}

			if( jQuery.browser.iphone )
			{
				$( '#' + $id ).css( 'background-color', '#ddd' );
			}else
			{
				$( '#' + $id ).css( 'background-color', '#f9f9f9' );
			}

			
			$( '#' + $id ).addClass( 'active' );
		};

		function _animateUsersIn( $group )
		{
			for( var i = 0; i < $group.length; i++ )
			{
				var id = $group[i].id;
				if( $( '#user-' + id ).css( 'opacity' ) != 1 )
				{
					// console.log( 'IN >', $group[i].full_name );
					$( '#user-' + id ).css( 'boxShadow', '1px 1px 3px 2px rgba(0,0,0,0.2)' );
					$( '#user-' + id ).animate(
						{ opacity: 1 },
						{
							duration: 1000,
							specialEasing: { opacity: 'easeInSine' }, 
							complete: function()
							{
							}
						}
					);
				}
			}
		};

		function _animateUsersOut( $group )
		{
			for( var i = 0; i < $group.length; i++ )
			{
				var id = $group[i].id;
				if( $( '#user-' + id ).css( 'opacity' ) >= 0.1 )
				{
					// console.log( 'OUT >', $group[i].full_name );
					$( '#user-' + id ).animate(
						{ opacity: 0.1 },
						{
							duration: 1000,
							specialEasing: { opacity: 'easeInSine' }, 
							complete: function()
							{
								$( this ).css( 'boxShadow', '0px 0px 0px 0px rgba(0,0,0,0)' );
							}
						}
					);
				}
			}
		};

		/**
		 * sorts the user list based on the users last name
		 * @param  {Object} $a user object containing user data
		 * @param  {Object} $b user object containing user data
		 * @return {int}
		 */
		function _sortOnUserLastName( $a, $b )
		{
			var aArr = $a.full_name.split( ' ' );
			var aValue = aArr[aArr.length - 1].charAt( 0 );
			var bArr = $b.full_name.split( ' ' );
			var bValue = bArr[bArr.length - 1].charAt( 0 );

			// ASCENDING, if you want DESCENDING, reverse the return values
			if( aValue > bValue )
			{
				return 1;
			}else if( aValue < bValue )
			{
				return -1;
			}else
			{
				//aValue == bValue
				return 0;
			}
		};

		function _addMouseOver( $el )
		{
			$el.mouseover(function()
			{
				// console.log( 'over', $( this ).hasClass( 'active' ) );
				// if( ! $( this ).hasClass( 'active' ) )
				// {
					$( this ).css( 'background-color', '#f9f9f9' );
				// }
				
			}).mouseout(function(){
				// console.log( 'out', $( this ).hasClass( 'active' ) );
				if( ! $( this ).hasClass( 'active' ) )
				{
					$( this ).css( 'background-color', '' );
				}
			});
		};

		function _userClickHandler( $evt )
		{

		};

		function _colorClickHandler( $evt )
		{
			var selector = $( $evt.target ).attr( 'data-filter' );
			if( ! selector )
			{
				selector = $( $evt.target ).parent().attr( 'data-filter' );
			}
			// console.log( selector );
			_setGroupName( _statuses[selector.split( '-' )[1]] );
			$( '#users' ).isotope({ filter: selector });
		};

		function _btnClickHandler( $evt )
		{
			// console.log( $evt.target.id );
			if( $evt.target.id == 'o' )
			{
				// console.log( 'toggle', _running );
				if( ! _running )
				{
					_startShow();
					$( '#o' ).html( '|' );
				}else
				{
					$( '#o' ).html( '-' );
					_stopShow();
				}
				return;
			}
			
			if( ! jQuery.browser.iphone )
			{
				_stopShow();
			}
			
			var selector = $( $evt.target ).attr( 'data-filter' );
			$( '#users' ).isotope({ filter: selector });
			_setActiveButtonByID( $evt.target.id );

			for( var i = _allLists.length - 1; i >= 0; i-- )
			{
				if( _allLists[i].id == $evt.target.id )
				{
					// console.log( _allLists[i].name );
					// _animateUsersIn( _allLists[i].list );
					_setGroupName( _allLists[i].name );
					// _setActiveButtonByID( $evt.target.id );
					// _animateUsersOut( _allLists[i].anti );

					break;
				};
			};
		};

		function _startShow()
		{
			_onChangeView();
			_running = true;
			_interval = setInterval( _onChangeView, 5000 );
		};

		function _stopShow()
		{
			_running = false;
			clearInterval( _interval );
		};

		function _setBrowser()
		{
			var userAgent = navigator.userAgent.toLowerCase();
			// console.log( 'useragent = ' + userAgent );

			// Figure out what browser is being used
			jQuery.browser = {
				
				version: (userAgent.match( /.+(?:rv|it|ra|ie|me|ve)[\/: ]([\d.]+)/ ) || [])[1],

				chrome: /chrome/.test( userAgent ),
				safari: /webkit/.test( userAgent ) && !/chrome/.test( userAgent ),
				opera: /opera/.test( userAgent ),
				firefox: /firefox/.test( userAgent ),
				msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ),

				mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ),

				webkit: $.browser.webkit,
				gecko: /[^like]{4} gecko/.test( userAgent ),
				presto: /presto/.test( userAgent ),

				xoom: /xoom/.test( userAgent ),

				android: /android/.test( userAgent ),
				androidVersion: (userAgent.match( /.+(?:android)[\/: ]([\d.]+)/ ) || [0,0])[1],

				iphone: /iphone|ipod/.test( userAgent ),
				iphoneVersion: (userAgent.match( /.+(?:iphone\ os)[\/: ]([\d_]+)/ ) || [0,0])[1].toString().split('_').join('.'),

				ipad: /ipad/.test( userAgent ),
				ipadVersion: (userAgent.match( /.+(?:cpu\ os)[\/: ]([\d_]+)/ ) || [0,0])[1].toString().split('_').join('.'),

				blackberry: /blackberry/.test( userAgent ),

				winMobile: /Windows\ Phone/.test( userAgent ),
				winMobileVersion: (userAgent.match( /.+(?:windows\ phone\ os)[\/: ]([\d_]+)/ ) || [0,0])[1]
			};

			jQuery.browser.mobile   =   ($.browser.iphone || $.browser.ipad || $.browser.android || $.browser.blackberry );
		};
	}
);