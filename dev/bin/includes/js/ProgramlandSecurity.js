
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
	var _transEndEventName = '';
	var _isBigScreen = false;

	var _colors = [ '#339900', '#FFCC00',, '#CC0033', '#DCDCDC' ];
	var _statuses = [ "Free","Slightly Busy", "Busy", "Out of Office" ];

	this.init = function init( $isBigScreen )
	{
		_isBigScreen = $isBigScreen;// note that this comes in as a number
		_setBrowser();
		_hasCSSTransitions = Modernizr.csstransitions;

		var transEndEventNames = {
			'WebkitTransition' : 'webkitTransitionEnd',
			'MozTransition'    : 'transitionend',
			'OTransition'      : 'oTransitionEnd',
			'msTransition'     : 'MSTransitionEnd',
			'transition'       : 'transitionend'
		};
		_transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ];

		setTimeout( function(){ window.scrollTo( 0, 1 ); }, 100 );

		$.getJSON( 'includes/php/getStatus.php?rt=json', _setStaff );
		_poll = setInterval( _onUpdateUserStatus, _pollInterval );

	};

	function _search( $evt )
	{
		if( _running )
		{
			_stopShow();
		}

		if( _catButtonIsActive() )
		{
			_removeActiveButton();
		}

		var searchterm = $( '#search' ).val().toLowerCase();
		var filter_items = [];

		$( '.user' ).each(
			function()
			{
				var username = $( this ).find( 'p' ).text().toLowerCase();

				if ( username.indexOf( searchterm ) !== -1 )
				{
					filter_items.push( '#' + $( this ).attr( 'id' ) );
				}
			}
		);

		if( filter_items.length )
		{
			var filter_string = filter_items.join( ', ' );

			// console.log( filter_string, $( filter_string ) );

			$( '#users' ).isotope( { filter: filter_string } );
		}

		$( '#group-name' ).html( 'search: ' + searchterm );
	};

	function _setStaff( $data )
	{
		_users = $data.users;
		_users.sort( _sortOnUserLastName );
		// console.log( _users );

		_allLists = [
			{'name': "Big Spaceship", 'id': 'all', 'filter': '.'},
			{'name': "Core", 'id': 'core', 'filter': '.core'},
			{'name': "Producers", 'id': 'producers', 'filter': '.producers'},
			{'name': "Engagement", 'id': 'engagement', 'filter': '.engagement'},
			{'name': "Strategy", 'id': 'strategy', 'filter': '.strategy'},
			{'name': "Technology", 'id': 'technology', 'filter': '.technology'},
			{'name': "Designers", 'id': 'designers', 'filter': '.designers'},

			{'name': "Squid Republic", 'id': 'squids', 'filter': '.squids'},
			// {'name': "The Special Bears", 'id': 'bears', 'filter': '.bears'},
			{'name': "Cheapies Playhaus", 'id': 'cheapies', 'filter': '.cheapies'},
			// {'name': "The Stephanies", 'id': 'stephanies', 'filter': '.stephanies'},
			{'name': "y [it's spanish]", 'id': 'y-its-spanish', 'filter': '.y-its-spanish'},
			// {'name': "Milkshake Enterprise", 'id': 'milkshake', 'filter': '.milkshake'}
			{'name': "Gentle Milk", 'id': 'gentle-milk', 'filter': '.gentle-milk'}
		];

		for( var i = 0; i < _users.length; i++ )
		{
			// sk: if status is -1, they no longer are here
			if( _users[i].status != '-1' )
			{
				// _users[i].status = Math.round( Math.random() * 4 );

				// grab the filters for isotope
				var filters = _users[i].discipline;
				for( var ii = _allLists.length - 1; ii >= 0; ii-- )
				{
					// if( _users[i].team != 'Core' && _allLists[ii].name == _users[i].team )
					if( _allLists[ii].name == _users[i].team )
					{
						filters += ' ' + _allLists[ii].id;
						break;
					}
				}

				filters +=  ' status-' + _users[i].status;

				// console.log( _users[i].full_name, filters );

				var name = _users[i].full_name;
				// var project = _users[i].current_project || "Totally free!";
				if( jQuery.browser.iphone )
				{
					var pieces = _users[i].full_name.split( ' ' );
					name = pieces[0].charAt( 0 ) + '. ' + pieces[pieces.length - 1];
				}
				// $( '#users' ).append( '<div class="user ' + filters
				// 	+ '" id="user-' + i
				// 	+ '" data-filter=".status-' + _users[i].status + '"><p>'
				// 	+ name + '<br><span>' + project + '</span></p></div>'
				// );
				// no longer using 'project' but instead a %
				var percent = _getPercentageValue( _users[i].status );
				$( '#users' ).append( '<div class="user ' + filters
					+ '" id="user-' + i
					+ '" data-filter=".status-' + _users[i].status + '"><p>'
					+ name + '<br><span>' + percent + '</span></p></div>'
				);

				// sk: why was I ever setting this? just use a CSS class, dummy!
				// $( '#user-' + i ).css( 'background', _colors[_users[i].status] );

				// _users[i].id = i;
				// _userColorList[name] = {
				_userColorList[_users[i].full_name] = {
					'id': i,
					'status': _users[i].status,
					// 'project': _users[i].current_project,
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

		}

		_updateStatusButtons();

		$( '.btn' ).click( _categoryClickHandler );
		_addMouseOver( $( '.btn' ) );

		$( '.user' ).click( _userClickHandler );
		$( '.color' ).click( _colorClickHandler );
		$( '.update-color' ).click( _updateColorClickHandler );
		$( '#change-color #close' ).click( _onCloseColorHandler );

		$( '#search' ).focus(
			function()
			{
				$( '#search' ).val( '' );
				if( $( '#change-color' ).hasClass( 'active' ) )
				{
					$( '#change-color #close' ).click();
				}
			}
		);
		$( "input, textarea" ).focus(
			function()
			{
				this.select();
			}
		);

		$( '#search' ).keyup( _search );
		// $( '#working-on' ).keyup( _sendNewUserData );

		if( _isBigScreen )
		{
			$( '#nav' ).hide();
			$( '#search' ).hide();
			$( '#colors' ).hide();
		};
		// $( '#nav' ).isotope({
		// 	itemSelector: '.btn',
		// 	layoutMode: 'fitRows',
		// 	animationEngine : 'best-available'
		// });

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

		_onChangeView();
		// if( jQuery.browser.iphone )
		// {
		// 	_onChangeView();
		// }else
		// {
		// 	_startShow();
		// }

		// humane.clickToClose = true;

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
					// if( _userColorList[n].color != _colors[$data.users[ii].status] ||
					// 	_userColorList[n].project != $data.users[ii].current_project
					// )
					if( _userColorList[n].color != _colors[$data.users[ii].status] )
					{
						// console.log( 'new project', $data.users[ii].current_project );
						var user = $( '#user-' + _userColorList[n].id );
						// user.css( '-webkit-transition', 'background-color .5s linear' );
						// user.css( '-moz-transition', 'background-color .5s linear' );
						// user.css( '-ms-transition', 'background-color .5s linear' );
						// user.css( '-o-transition', 'background-color .5s linear' );
						// user.css( 'transition', 'background-color .5s linear' );

						// user.css( 'background-color', _colors[$data.users[ii].status] );
						user.attr( 'data-filter', '.status-' + $data.users[ii].status );
						user.removeClass( 'status-' + _userColorList[n].status );
						user.addClass( 'status-' + $data.users[ii].status );
						// $( '#user-' + _userColorList[n].id + ' span' ).html( $data.users[ii].current_project );
						$( '#user-' + _userColorList[n].id + ' span' ).html( _getPercentageValue( $data.users[ii].status ) );

						_userColorList[n].color = _colors[$data.users[ii].status];
						_userColorList[n].status = $data.users[ii].status;
						// _userColorList[n].project = $data.users[ii].current_project;
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
		$( '#users' ).isotope( { filter: selector } );
	};

	function _setGroupName( $name )
	{
		if( _hasCSSTransitions )
		{
			_newGroupName = $name;
			// setting last arg to true causes function to be called 2x
			$( '#group-name' )[0].addEventListener( _transEndEventName, _reanimateGroupName );
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
		$evt.target.removeEventListener( _transEndEventName, _reanimateGroupName );
		$( '#group-name' ).html( _newGroupName );
		$( '#group-name' ).css( 'opacity', 1 );
		// _newGroupName = 'WTF'; // clearing this (or setting it to something else) will change it in the DOM ??
	};

	function _setActiveButtonByID( $id )
	{
		_removeActiveButton();

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
		if( _isBigScreen ) return;

		$( '#search' ).val( '' );

		var id = $( $evt.target ).attr( 'id' ) ||
			$( $evt.target ).parent().attr( 'id' ) ||
			$( $evt.target ).parent().parent().attr( 'id' );

		// console.log( '_userClickHandler', id );
		_currentUserID = id;
		var name = _getNameFromID( _currentUserID.split( '-' )[1] );
		// var project = _getProjectFromID( _currentUserID.split( '-' )[1] ) || "Totally free!";

		$( '#change-color p' ).html( name );
		// $( '#working-on' ).val( project );
		// $( '#working-on' ).focus();

		if( _hasCSSTransitions )
		{
			$( '#change-color' ).addClass( 'active' );
			$( '#change-color' ).css( {left: $evt.pageX, top: $evt.pageY, opacity: 1} );
		}else
		{
			$( '#change-color' ).css( {left: $evt.pageX, top: $evt.pageY} );
			$( '#change-color' ).addClass( 'active' );
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
			// var newProject = $( '#working-on' ).val();
			$.post(
				'includes/php/updateStatus.php',
				// { action: 'update', name: name, status: newStatus, project: newProject },
				{ action: 'update', name: name, status: newStatus },
				function( $data )
				{
					if( $data.success )
					{
						// humane.success( name + "'s' status has been updated." );
						// humane.error( "There was an error, sorry." );
						_updateStaff( $data );
					}else
					{
						console.log( 'error' );
						// humane.error( "There was an error, sorry." );
					}
					// $( '#change-color' ).css( 'opacity', 0 );
					_onCloseColorHandler( $evt );
				},
				"json"
			);
		}
	};

	function _sendNewUserData( $evt )
	{
		if( $evt.keyCode == '13' )// ENTER
		{
			if( _currentUserID )
			{
				var name = _getNameFromID( _currentUserID.split( '-' )[1] );
				// var newProject = $( '#working-on' ).val();
				$.post(
					'includes/php/updateStatus.php',
					// { action: 'update', name: name, project: newProject },
					{ action: 'update', name: name },
					function( $data )
					{
						console.log( $data.success );
						if( $data.success )
						{
							// humane.success( name + "'s' status has been updated." );
							// humane.error( "There was an error, sorry." );
							_updateStaff( $data );
							// $( '#working-on' ).val( '' );
						}else
						{
							console.log( 'error' );
							// humane.error( "There was an error, sorry." );
						}
						// $( '#change-color' ).css( 'opacity', 0 );
						_onCloseColorHandler( $evt );
					},
					"json"
				);
				// $evt.preventDefault();
			}
		}
	};

	function _onCloseColorHandler( $evt )
	{
		// $( '#change-color' ).css( 'opacity', 0 );
		// $( '#change-color' ).removeClass( 'active' );
		if( _hasCSSTransitions )
		{
			$( '#change-color' ).removeClass( 'active' );
			$( '#change-color' )[0].addEventListener( _transEndEventName, _moveColorChange );
			$( '#change-color' ).css( 'opacity', 0 );
		}else
		{
			$( '#change-color' ).removeClass( 'active' );
			$( '#change-color' ).css( {top: '-500px'} );
			$( '#change-color' ).animate(
				{ opacity: 0 },
				{
					duration: 500,
					specialEasing: { opacity: 'easeInSine' },
					complete: function()
					{
					}
				}
			);
		}
	};

	function _moveColorChange( $evt )
	{
		$evt.target.removeEventListener( _transEndEventName, _moveColorChange );
		$( '#change-color' ).css( {top: '-500px'} );
	};

	function _colorClickHandler( $evt )
	{
		$( '#search' ).val( '' );

		// sk: check to see if the color I've clicked on is in use
		// TODO: use a class
		if( _statusesInUse.indexOf( $evt.target.id.split( '-' )[1] ) != -1 )
		{
			if( $( '#change-color' ).hasClass( 'active' ) )
			{
				_onCloseColorHandler( $evt );
			}

			_stopShow();
			_removeActiveButton();

			var selector = $( $evt.target ).attr( 'data-filter' );
			if( ! selector )
			{
				selector = $( $evt.target ).parent().attr( 'data-filter' );
			}
			// console.log( selector );
			_setGroupName( _statuses[selector.split( '-' )[1]] );
			$( '#users' ).isotope( { filter: selector } );
		}
	};

	function _removeActiveButton()
	{
		for( var i = _allLists.length - 1; i >= 0; i-- )
		{
			$( '#' + _allLists[i].id ).css( 'background-color', '' );
			$( '#' + _allLists[i].id ).removeClass( 'active' );
		}
	};

	function _catButtonIsActive()
	{
		for( var i = _allLists.length - 1; i >= 0; i-- )
		{
			if( $( '#' + _allLists[i].id ).hasClass( 'active' ) )
			{
				return true;
			}
		}
		return false;
	};

	function _categoryClickHandler( $evt )
	{
		$( '#search' ).val( '' );

		if( $( '#change-color' ).hasClass( 'active' ) )
		{
			_onCloseColorHandler( $evt );
		}

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
		$( '#users' ).isotope( { filter: selector } );
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
		for( var i = _colors.length - 1; i >= 0; i-- )
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

	function _getProjectFromID( $id )
	{
		for( var n in _userColorList )
		{
			// console.log( _userColorList[n].id );
			if( _userColorList[n].id == $id )
			{
				return _userColorList[n].project;
			}
		}
	};

	function _getPercentageValue( $status )
	{
		var r = '--';
		switch( $status )
		{
			case '0' :
				r = '100%';
			break;
			case '1' :
				r = '75%';
			break;
			case '2' :
				r = '50%';
			break;
			case '3' :
				r = '25%';
			break;
			case '4' :
				r = '0%';
			break;
		}

		return r;
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