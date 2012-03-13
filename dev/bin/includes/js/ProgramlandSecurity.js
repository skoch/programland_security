
var ProgramlandSecurity = new(function()
{
	var _self = this;

	var _users;
	var _testSquare;
	var _boxWidth = 245;
	var _boxHeight = 50;
	var _iterations = 0;
	var _inCount = 0;
	var _usersToAnimateIn = 0;
	var _interval;
	var _poll;
	var _running = false;
	var _showInterval = 10000;
	var _pollInterval = 1000 * 60 * 30; // every 30 minutes ?
	var _userColorList = [];
	var _statusesInUse = [];
	var _currentUserID;
	var _hasCSSTransitions = false;
	var _newGroupName = '';
	var _eventName = '';
	
	var _colors = [ '#339900', '#006699', '#FFCC00', '#FF9900', '#CC0033' ];
	var _statuses = ["Free","A Little Workload", "Pretty Crazy", "Insane", "Leave me the fuck alone" ];

	this.init = function init()
	{
		_setBrowser();
		_hasCSSTransitions = Modernizr.csstransitions;

		if( _hasCSSTransitions )
		{
			if( jQuery.browser.chrome || jQuery.browser.safari )
			{
				_eventName = 'webkitTransitionEnd';
			}else if( jQuery.browser.opera )
			{
				_eventName = 'oTransitionEnd';
			}else if( jQuery.browser.firefox )
			{
				_eventName = 'transitionend';
			}else if( jQuery.browser.msie )
			{
				_eventName = 'MSTransitionEnd';
			}
		}
		
		setTimeout( function(){ window.scrollTo( 0, 1 ); }, 100 );

		$.getJSON( 'includes/php/getStatus.php?rt=json', _setStaff );
		_poll = setInterval( _onUpdateUserStatus, _pollInterval );
	};

	function _setStaff( $data )
	{
		_users = $data.users;
		_users.sort( _sortOnUserLastName );
		// console.log( _users );

		_allLists = [
			// {'name': "Big Spaceship", 'id': 'all', 'filter': '.'},
			{'name': "Core", 'id': 'core', 'filter': '.core'},
			{'name': "Producers", 'id': 'producers', 'filter': '.producers'},
			{'name': "Strategy", 'id': 'strategy', 'filter': '.strategy'},
			{'name': "Technology", 'id': 'technology', 'filter': '.technology'},
			{'name': "Designers", 'id': 'designers', 'filter': '.designers'},
			{'name': "Squid Republic", 'id': 'squids', 'filter': '.squids'},
			{'name': "The Special Bears", 'id': 'bears', 'filter': '.bears'},
			{'name': "Cheapies Playhaus", 'id': 'cheapies', 'filter': '.cheapies'},
			{'name': "The Stephanies", 'id': 'stephanies', 'filter': '.stephanies'},
			{'name': "y [it's spanish]", 'id': 'robots', 'filter': '.robots'},
			{'name': "Milkshake Enterprise", 'id': 'milkshake', 'filter': '.milkshake'}
		];

		for( var i = 0; i < _users.length; i++ )
		{
			// _users[i].status = Math.round( Math.random() * 4 );

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

			// var x = ( ( _boxWidth ) + 10 ) * ( i % 5 );
			// var y = ( ( _boxHeight ) + 10 ) * parseInt( i / 5 );
			var name = _users[i].full_name;
			if( jQuery.browser.iphone )
			{
				var pieces = _users[i].full_name.split( ' ' );
				name = pieces[0].charAt( 0 ) + '. ' + pieces[pieces.length - 1];
			}
			$( '#users' ).append( '<div class="user ' + filters
				+ '" id="user-' + i
				+ '" data-filter=".status-' + _users[i].status + '"><p>'
				+ name + '</p></div>'
			);
			$( '#user-' + i ).css( {backgroundColor: _colors[_users[i].status]} );

			// _users[i].id = i;
			// _userColorList[name] = {
			_userColorList[_users[i].full_name] = {
				'id': i, 
				'status': _users[i].status,
				'color': _colors[_users[i].status]
			};

			_statusesInUse.push( _users[i].status );

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

		_updateStatusButtons();

		$( '.btn' ).click( _btnClickHandler );
		_addMouseOver( $( '.btn' ) );

		$( '.user' ).click( _userClickHandler );
		$( '.color' ).click( _colorClickHandler );
		$( '.update-color' ).click( _updateColorClickHandler );
		$( '#change-color #close' ).click( _onCloseColorHandler );
		// $( 'body' ).click(function()
		// {
		// 	console.log( '>>>' );
		// 	if( $( '#change-color' ).css( 'opacity' ) )
		// 	{
		// 		$( '#change-color' ).css( {opacity: 0} );
		// 	}
		// })

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

		if( _hasCSSTransitions )
		{
			$( '#container' ).css( 'opacity', 1 );
		}else
		{
			$( '#container' ).animate(
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

	function _updateStaff( $data )
	{
		_statusesInUse = [];
		for( var n in _userColorList )
		{
			for( var ii = $data.users.length - 1; ii >= 0; ii-- )
			{
				var name = $data.users[ii].full_name;
				if( jQuery.browser.iphone )
				{
					var pieces = $data.users[ii].full_name.split( ' ' );
					name = pieces[0].charAt( 0 ) + '. ' + pieces[pieces.length - 1];
				}
				
				_statusesInUse.push( $data.users[ii].status );

				if( name == n )
				{
					if( _userColorList[n].color != _colors[$data.users[ii].status] )
					{
						var user = $( '#user-' + _userColorList[n].id );
						// user.css( '-webkit-transition', 'background-color .5s linear' );
						// user.css( '-moz-transition', 'background-color .5s linear' );
						// user.css( '-ms-transition', 'background-color .5s linear' );
						// user.css( '-o-transition', 'background-color .5s linear' );
						// user.css( 'transition', 'background-color .5s linear' );

						user.css( 'background-color', _colors[$data.users[ii].status] );
						user.attr( 'data-filter', '.status-' + $data.users[ii].status );
						user.removeClass( 'status-' + _userColorList[n].status );
						user.addClass( 'status-' + $data.users[ii].status );

						_userColorList[n].color = _colors[$data.users[ii].status];
						_userColorList[n].status = $data.users[ii].status;
					}

					break;
				};
			}
		}
		_updateStatusButtons();
	};

	function _onUpdateUserStatus()
	{
		$.getJSON( 'includes/php/getStatus.php?rt=json', _updateStaff );
	};

	function _onChangeView()
	{
		var i = _iterations++ % _allLists.length;

		_setGroupName( _allLists[i].name );
		_setActiveButtonByID( _allLists[i].id );
		var selector = _allLists[i].filter;
		$( '#users' ).isotope({ filter: selector });
	};

	function _setGroupName( $name )
	{
		if( _hasCSSTransitions )
		{
			_newGroupName = $name;
			// setting last arg to true causes function to be called 2x
			$( '#group-name' )[0].addEventListener( _eventName, _reanimateGroupName );
			$( '#group-name' ).css( 'opacity', 0 );

		}else
		{
			$( '#group-name' ).animate(
				{ opacity: 0 },
				{
					duration: 1000,
					specialEasing: { opacity: 'easeInSine' }, 
					complete: function()
					{
						$( this ).html( $name );
						$( '#group-name' ).animate(
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
			);
		}
	};

	function _reanimateGroupName( $evt )
	{
		// console.log( '_reanimateGroupName', $evt );
		$evt.target.removeEventListener( _eventName, _reanimateGroupName );
		$( '#group-name' ).html( _newGroupName );
		$( '#group-name' ).css( 'opacity', 1 );
		// _newGroupName = 'WTF'; // clearing this (or setting it to something else) will change it in the DOM ??
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

	/**
	 * sorts the user list based on the users last name
	 * @param  {Object} $a user object containing user data
	 * @param  {Object} $b user object containing user data
	 * @return {int}
	 */
	function _sortOnUserLastName( $a, $b )
	{
		var aArr = $a.full_name.split( ' ' );
		// var aValue = aArr[aArr.length - 1].charAt( 0 );
		var aValue = aArr[aArr.length - 1].toLowerCase();
		var bArr = $b.full_name.split( ' ' );
		// var bValue = bArr[bArr.length - 1].charAt( 0 );
		var bValue = bArr[bArr.length - 1].toLowerCase();

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
			$( this ).css( 'background-color', '#f9f9f9' );			
		}).mouseout(function(){
			if( ! $( this ).hasClass( 'active' ) )
			{
				$( this ).css( 'background-color', '' );
			}
		});
	};

	function _userClickHandler( $evt )
	{
		var id = $( $evt.target ).attr( 'id' );
		if( ! id )
		{
			id = $( $evt.target ).parent().attr( 'id' );
		}
		// console.log( '_userClickHandler', id );
		_currentUserID = id;
		var name = _getNameFromID( _currentUserID.split( '-' )[1] );
		// todo: update all opacity animations to use CSS transitions or jQuery
		$( '#change-color p' ).html( name );
		if( _hasCSSTransitions )
		{
			$( '#change-color' ).css( {left: $evt.pageX, top: $evt.pageY, opacity: 1} );
		}else
		{
			$( '#change-color' ).css( {left: $evt.pageX, top: $evt.pageY} );
			$( '#change-color' ).animate(
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
		
		_stopShow();

	};

	function _updateColorClickHandler( $evt )
	{
		if( _currentUserID )
		{
			var name = _getNameFromID( _currentUserID.split( '-' )[1] );
			var newStatus = $evt.target.id.split( '-' )[1];
			$.post(
				'includes/php/updateStatus.php',
				{ action: 'update', name: name, status: newStatus },
				function( $data )
				{
					if( $data.success )
					{
						_updateStaff( $data );
					}else
					{
						console.log( 'error' );
					}
					$( '#change-color' ).css( 'opacity', 0 );
				},
				"json"
			);
		}
	};

	function _onCloseColorHandler( $evt )
	{
		$( '#change-color' ).css( 'opacity', 0 );
	};
	function _colorClickHandler( $evt )
	{
		if( _statusesInUse.indexOf( $evt.target.id.split( '-' )[1] ) != -1 )
		{
			_stopShow();

			// remove active button
			for( var i = _allLists.length - 1; i >= 0; i-- )
			{
				$( '#' + _allLists[i].id ).css( 'background-color', '' );
				$( '#' + _allLists[i].id ).removeClass( 'active' );
			}

			var selector = $( $evt.target ).attr( 'data-filter' );
			if( ! selector )
			{
				selector = $( $evt.target ).parent().attr( 'data-filter' );
			}
			// console.log( selector );
			_setGroupName( _statuses[selector.split( '-' )[1]] );
			$( '#users' ).isotope({ filter: selector });
		}
	};

	function _btnClickHandler( $evt )
	{
		// console.log( $evt.target.id );
		if( $evt.target.id == 'o' )
		{
			if( ! _running )
			{
				_startShow();
			}else
			{
				_stopShow();
			}
			return;
		}
		
		_stopShow();
		
		var selector = $( $evt.target ).attr( 'data-filter' );
		$( '#users' ).isotope({ filter: selector });
		_setActiveButtonByID( $evt.target.id );

		for( var i = _allLists.length - 1; i >= 0; i-- )
		{
			if( _allLists[i].id == $evt.target.id )
			{
				_setGroupName( _allLists[i].name );
				break;
			};
		};
	};

	function _startShow()
	{
		_onChangeView();
		$( '#o' ).html( '*' );
		_running = true;
		_interval = setInterval( _onChangeView, _showInterval );
	};

	function _stopShow()
	{
		if( ! jQuery.browser.iphone )
		{
			$( '#o' ).html( '—' );
			_running = false;
			clearInterval( _interval );
		}
	};

	Array.prototype.unique = function()
	{
		var a = [];
		var l = this.length;
		for( var i = 0; i < l; i++ )
		{
			for( var j = i + 1; j < l; j++ )
			{
				// If this[i] is found later in the array
				if( this[i] === this[j] )
					j = ++i;
			}
			a.push( this[i] );
		}
		return a;
	};

	function _updateStatusButtons()
	{
		_statusesInUse = _statusesInUse.unique();
		for( var i = 4; i >= 0; i-- )
		{
			$( '#c-' + i ).addClass( 'inactive' );
		}

		for( var i = _statusesInUse.length - 1; i >= 0; i-- )
		{
			$( '#c-' + _statusesInUse[i] ).removeClass( 'inactive' );
		}
	};

	function _getNameFromID( $id )
	{
		// console.log( $id );
		for( var n in _userColorList )
		{
			// console.log( _userColorList[n].id );
			if( _userColorList[n].id == $id )
			{
				// console.log( n );
				return n;
			}
		}
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

})();