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
		
		init();

		function init()
		{
			console.log( 'INIT' );

			_addMouseOver( $( '.btn' ) );
			$( '.btn' ).click( _clickHandler );
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
				{'list': _users, 'anti': [], 'name': "Big Spaceship", 'id': 'all'},
				{'list': _coreList, 'anti': _coreAntiList, 'name': "Core", 'id': 'core'},
				{'list': _codersList, 'anti': _codersAntiList, 'name': "Coders", 'id': 'coders'},
				{'list': _producersList, 'anti': _producersAntiList, 'name': "Producers", 'id': 'producers'},
				{'list': _designersList, 'anti': _designersAntiList, 'name': "Designers", 'id': 'designers'},
				{'list': _strategyList, 'anti': _strategyAntiList, 'name': "Strategy", 'id': 'strategy'},
				{'list': _squidsList, 'anti': _squidsAntiList, 'name': "Squid Republic", 'id': 'squids'},
				{'list': _bearsList, 'anti': _bearsAntiList, 'name': "The Special Bears", 'id': 'bears'},
				{'list': _cheapiesList, 'anti': _cheapiesAntiList, 'name': "Cheapies Playhaus", 'id': 'cheapies'},
				{'list': _stephaniesList, 'anti': _stephaniesAntiList, 'name': "The Stephanies", 'id': 'stephanies'},
				{'list': _robotsList, 'anti': _robotsAntiList, 'name': "Candy Robots", 'id': 'robots'},
				{'list': _milkshakeList, 'anti': _milkshakeAntiList, 'name': "Milkshake Enterprise", 'id': 'milkshake'},
				{'list': _noTeamList, 'anti': _noTeamAntiList, 'name': "Unassigned!", 'id': 'none'},
			];

			// console.log( 'users', _users );
			var items = [];
			var _running_height = 0;
			for( var i = 0; i < _users.length; i++ )
			{
				_users[i].status = Math.round( Math.random() * 4 );
				// console.log( _users[i] );

				var x = ((_boxWidth) + 10) * (i % 5);
				var y = ((_boxHeight) + 10) * parseInt(i / 5);
				$( '#users' ).append( '<div class="user" id="user-' + i + '"><p>' + _users[i].full_name + '</p></div>' );
				$( '#user-' + i ).css( {left: Number( x ), top: Number( y ), backgroundColor: _colors[_users[i].status]} );
				
				_running_height += ( x == 0 ) ? _boxHeight + 10 : 0;
				_users[i].id = i;
				
				// console.log( _users[i].team, _users[i].team.indexOf( "Bears" ) );

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

			$( '#users' ).css( 'height', _running_height );

			$( '#top-bar' ).animate(
				{ opacity: 1 },
				{
					duration: 1000,
					specialEasing: { opacity: 'easeInSine' }, 
					complete: function()
					{
					}
				}
			);

			_startShow();
		};

		function _onChangeView()
		{
			var i = _iterations++ % _allLists.length;
			_animateUsersIn( _allLists[i].list );
			_setGroupName( _allLists[i].name );
			
			_setActiveButtonByID( _allLists[i].id );
			
			_animateUsersOut( _allLists[i].anti );
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
				$( '#' + _allLists[i].id ).css( 'background-color', '#fff' );
				$( '#' + _allLists[i].id ).removeClass( 'active' );
			}

			$( '#' + $id ).css( 'background-color', '#f9f9f9' );
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
					$( this ).css( 'background-color', '#fff' );
				}
			});
		};

		function _clickHandler( $evt )
		{
			// console.log( $evt.target.id );
			if( $evt.target.id == 'o' )
			{
				console.log( 'toggle', _running );
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
			
			_stopShow();

			for( var i = _allLists.length - 1; i >= 0; i-- )
			{
				if( _allLists[i].id == $evt.target.id )
				{
					// console.log( _allLists[i].name );
					_animateUsersIn( _allLists[i].list );
					_setGroupName( _allLists[i].name );
					_setActiveButtonByID( $evt.target.id );
					_animateUsersOut( _allLists[i].anti );

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
	}
);