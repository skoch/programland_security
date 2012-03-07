package com.bigspaceship.programland_security
{	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	// import gs.TweenLite;		
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Expo;
	import com.greensock.plugins.*;

	import com.bigspaceship.display.StandardButton;
	import com.bigspaceship.utils.Out;
	
	public class ProgramlandSecurity extends EventDispatcher
	{
		private var _mc						: MovieClip;
		private var _statusColors			: Array = [0x339900, 0x006699, 0xFFCC00, 0xFF9900, 0xCC0033];
		private var _hexColors				: Array = ['#339900', '#006699', '#FFCC00', '#FF9900', '#CC0033'];
		/*private var _statusColors			: Array = [0x329800, 0x006598, 0xFFCC00, 0xFF9800, 0xCC0032];*/
		private var _codersList				: Array = [];
		private var _mainList				: Array = [];
		private var _producersList			: Array = [];
		private var _designersList			: Array = [];
		private var _strategyList			: Array = [];
		private var _qaList					: Array = [];
		private var _squidsList				: Array = [];
		private var _bearsList				: Array = [];
		private var _cheapiesList			: Array = [];
		private var _stephaniesList			: Array = [];
		private var _robotsList				: Array = [];
		private var _startColorList			: Array = [];
		private var _staffList				: Array = [];
		private var _currentView			: String = 'all';
		private var _urlloader				: URLLoader;
		private var _content         		: XML;
		private var _pollTimer         		: Timer;
		private var _pollDelay         		: Number = 30;
		private var _server					: String = "http://skoch.local/programland_security/includes/php/getStatus.php";
		
		private var _all_btn				: StandardButton;
		private var _main_btn				: StandardButton;
		private var _coders_btn				: StandardButton;
		private var _producers_btn			: StandardButton;
		private var _designers_btn			: StandardButton;
		private var _strategy_btn			: StandardButton;
		private var _squids_btn				: StandardButton;
		private var _bears_btn				: StandardButton;
		private var _cheapies_btn			: StandardButton;
		private var _stephanies_btn			: StandardButton;
		private var _robots_btn				: StandardButton;
		private var _low_btn				: StandardButton;
		private var _severe_btn				: StandardButton;
		private var _guarded_btn			: StandardButton;
		private var _elevated_btn			: StandardButton;
		private var _high_btn				: StandardButton;

		public static const LOW				: Number = 0;
		public static const GUARDED			: Number = 1;
		public static const ELEVATED		: Number = 2;
		public static const HIGH			: Number = 3;
		public static const SEVERE			: Number = 4;
		
		public function ProgramlandSecurity( $mc:MovieClip ):void
		{
			super();

			Out.enableAllLevels();
			Out.info( this, "CONSTRUCT" );
			TweenPlugin.activate( [TintPlugin] );

			_mc = $mc;
			
			if( _mc.stage ) _startPoll();
			else _mc.addEventListener( Event.ADDED_TO_STAGE, _startPoll );
		};
		
		private function _startPoll( $evt:Event = null ):void
		{
			Out.info( this, "_startPoll" );
			_mc.removeEventListener( Event.ADDED_TO_STAGE, _startPoll );

			_urlloader = new URLLoader();
			_urlloader.load( new URLRequest( _server ) );
			_urlloader.addEventListener( Event.COMPLETE, _onContentComplete, false, 0, true );
			
			// start the polling
			_pollTimer = new Timer( _pollDelay * 1000 );
			_pollTimer.addEventListener( TimerEvent.TIMER, _pollSecurityLevels, false, 0, true );	
			_pollTimer.start();
		};		
		
		private function _pollSecurityLevels( $evt:TimerEvent ):void
		{
			Out.info( this, "_pollSecurityLevels" );
			_urlloader = new URLLoader();
			_urlloader.load( new URLRequest( _server) );
			_urlloader.addEventListener( Event.COMPLETE, _updateSecurityLevel, false, 0, true );
		};
		
		
		private function _updateSecurityLevel( $evt:Event = null ):void
		{
			Out.info( this, "_updateSecurityLevel" );
			_content = null;
			_content = new XML( _urlloader.data );
			_urlloader = null;
			
			for( var i:Number = 0; i < _content.user.length(); i++ )
			{
				if( _startColorList[i] != _statusColors[Number(_content.user[i].status)] )
				{
					// TweenLite.to(_staffList[i].bg, 3.25, {mcColor:_statusColors[Number(_content.user[i].status)]});
					TweenLite.to(_staffList[i].bg, 3.25, {tint:_statusColors[Number(_content.user[i].status)]});
					_startColorList[i] = _statusColors[Number( _content.user[i].status )];
				}
			}
		};
		

		//private function _loadConfigXML():void
		//{
		//	var l:URLLoader = new URLLoader();
		//		l.addEventListener( Event.COMPLETE, _onConfigXMLLoadComplete_handler );
		//		l.load( new URLRequest( 'includes/xml/staff.xml' ) );
		//};
		//
		//private function _onConfigXMLLoadComplete_handler( $evt:Event ):void
		//{
		//	var staff:XML = XML($evt.target.data);
		//	var i:uint = 1;
		//	for each (var employee:XML in staff.employee)
		//	{
		//		var short_name:String = employee.name.substr(0, 1).toLowerCase() + employee.name.split(' ')[1].toLowerCase();
		//		var email:String  = employee.name.substr(0, 1).toLowerCase() + "." + employee.name.split(' ')[1].toLowerCase() + "@bigspaceship.com";
		//		
		//		//trace( "INSERT INTO `staff_list` VALUES(" + i + ", '" + short_name + "', '" + employee.name + "', '" + employee.role + "', '" + employee.affiliations + "', '" + email + "', 'asdzxc;', 0);");
		//		//trace(employee.name, employee.role)
		//		i++;
		//	}
		//};

		private function _init():void
		{
			var i:uint = 0;
			/*for(var i:Number = 0; i < _content.user.length(); i++)*/
			for each ( var item:String in _content.user )
			{
				Out.info( this, "_content.user["+i+"]\n" + _content.user[i] );
				//var target:MovieClip = this[_content.user[i].name.toLowerCase()];
				var target:MovieClip = new devClip();
				/*target.x = ((150) + 15) * (i % 2);*/
				/*target.y = ((50) + 20) * int(i / 2);*/
				/*target.bg.width = 512 / 2;*/
				
				//target.x = 10;
				//target.y = i * (target.height + 10) + 15;
				//target.bg.width = 512 - 20;
				
				target.x = 5 + ((250) + 5) * (i % 5);
				target.y = 65 + ((50) + 5) * int(i / 5);
				
				// TweenLite.to(target.bg, 0.25, {mcColor:_statusColors[Number(_content.user[i].status)]});
				TweenLite.to(target.bg, 0.25, {tint:_statusColors[Number(_content.user[i].status)]});
				target.txt.text = _content.user[i].name;
				//var l:TextField = _setDevName(_content.user[i].name);
				//l.x = (target.width / 2 - l.width / 2) + target.x;
				//l.y = (target.height / 2 - l.height / 2) + target.y + 2;
				_mc.addChild( target );
				//addChild(l);
				
				_startColorList.push( _statusColors[Number(_content.user[i].status)] );
				
				_staffList.push( target );
				
				if(_content.user[i].discipline.indexOf("*") == -1) _mainList.push( target );
				if(_content.user[i].discipline.indexOf("technology") == -1) _codersList.push( target );
				if(_content.user[i].discipline.indexOf("producers") == -1) _producersList.push( target );
				if(_content.user[i].discipline.indexOf("designers") == -1) _designersList.push( target );
				if(_content.user[i].discipline.indexOf("strategy") == -1) _strategyList.push( target );
				// if(_content.user[i].discipline.indexOf("qa") == -1) _qaList.push( target );
				if(_content.user[i].discipline.indexOf("Squid") == -1) _squidsList.push( target );
				if(_content.user[i].discipline.indexOf("Bears") == -1) _bearsList.push( target );
				if(_content.user[i].discipline.indexOf("Cheapies") == -1) _cheapiesList.push( target );
				if(_content.user[i].discipline.indexOf("Stephanies") == -1) _stephaniesList.push( target );
				if(_content.user[i].discipline.indexOf("Robot") == -1) _robotsList.push( target );
				
				i++;
			}
			
			_mc.affiliate_txt.text = _currentView;
			_setButtons();
		};
		
		
		private function _setButtons():void
		{
			_all_btn = new StandardButton( _mc.all );
			_main_btn = new StandardButton( _mc.main );
			_coders_btn = new StandardButton( _mc.coders );
			_producers_btn = new StandardButton( _mc.producers );
			_designers_btn = new StandardButton( _mc.designers );
			_strategy_btn = new StandardButton( _mc.strategy );
			_squids_btn = new StandardButton( _mc.squids );
			_bears_btn = new StandardButton( _mc.bears );
			_cheapies_btn = new StandardButton( _mc.cheapies );
			_stephanies_btn = new StandardButton( _mc.stephanies );
			_robots_btn = new StandardButton( _mc.robots );

			_all_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewAll_handler, false, 0, true );
			_main_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_coders_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_producers_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_designers_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_strategy_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_squids_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_bears_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_cheapies_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_stephanies_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			_robots_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeView_handler, false, 0, true );
			
			// _mc.all.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.main.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.coders.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.producers.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.designers.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.strategy.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.squids.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.bears.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.cheapies.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.stephanies.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			// _mc.robots.addEventListener( MouseEvent.MOUSE_OVER, _onOver_handler, false, 0, true );
			
			// _mc.all.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.main.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.coders.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.producers.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.designers.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.strategy.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.squids.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.bears.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.cheapies.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.stephanies.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			// _mc.robots.addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			
			_low_btn = new StandardButton( _mc.low );
			_guarded_btn = new StandardButton( _mc.guarded );
			_elevated_btn = new StandardButton( _mc.elevated );
			_high_btn = new StandardButton( _mc.high );
			_severe_btn = new StandardButton( _mc.severe );

			_low_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewByColor_handler, false, 0, true );
			_guarded_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewByColor_handler, false, 0, true );
			_elevated_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewByColor_handler, false, 0, true );
			_high_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewByColor_handler, false, 0, true );
			_severe_btn.btn.addEventListener( MouseEvent.CLICK, _onChangeViewByColor_handler, false, 0, true );
			
			//this.low.addEventListener( MouseEvent.MOUSE_OVER, _onOver2_handler, false, 0, true );
			//this.guarded.addEventListener( MouseEvent.MOUSE_OVER, _onOver2_handler, false, 0, true );
			//this.elevated.addEventListener( MouseEvent.MOUSE_OVER, _onOver2_handler, false, 0, true );
			//this.high.addEventListener( MouseEvent.MOUSE_OVER, _onOver2_handler, false, 0, true );
			//this.severe.addEventListener( MouseEvent.MOUSE_OVER, _onOver2_handler, false, 0, true );
			//
			//this.low.addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
			//this.guarded.addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
			//this.elevated.addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
			//this.high.addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
			//this.severe.addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
		};
		
		private function _onChangeView_handler( $evt:MouseEvent ):void
		{
			Out.info( this, "$evt.target: " + $evt.target );
			Out.info( this, "$evt.currentTarget: " + $evt.currentTarget );
			_currentView = $evt.target.parent.name;
			_mc.affiliate_txt.text = _currentView;
			
			for( var i:int = 0; i < _staffList.length; i++ )
			{
				if( _staffList[i].alpha != 1 ) TweenLite.to( _staffList[i], 0.25, {alpha:1} );
			}
			
			var list:Array = this['_' + _currentView + 'List'];
			for( var ii:int = 0; ii < list.length; ii++ )
			{
				TweenLite.to( list[ii], 0.25, {alpha:.1} );
			}
		};
		
		private function _onChangeViewAll_handler( $evt:MouseEvent ):void
		{
			Out.info( this, "> " + $evt.target.parent.name );
			_currentView = $evt.target.parent.name;
			for( var i:int = 0; i < _staffList.length; i++ )
			{
				Out.info( this, "_staffList[i]: " + _staffList[i] + ", " + _staffList[i].alpha );
				if( _staffList[i].alpha != 1 ) TweenLite.to(_staffList[i], 0.25, {alpha:1});
			}
			// this[_currentView].removeEventListener( MouseEvent.MOUSE_OUT, _onOut_handler );
		};
		
		private function _onChangeViewByColor_handler( $evt:MouseEvent ):void
		{
			//_currentView = $evt.target.name;
			
			for( var i:int = 0; i < _staffList.length; i++ )
			{
				if( _staffList[i].alpha == 1 ) TweenLite.to(_staffList[i], 0.25, {alpha:.1});
			}
			
			for( var ii:Number = 0; ii < _content.user.length(); ii++ )
			{
				if( _startColorList[ii] == _statusColors[ProgramlandSecurity[$evt.target.parent.name.toUpperCase()]] )
				{
					TweenLite.to(_staffList[ii], 0.25, {alpha:1});
				}
			}
			//this[_currentView].removeEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler );
		};
		
		private function _onOver_handler( $evt:MouseEvent ):void
		{
			trace($evt.target, $evt.currentTarget, $evt.currentTarget.totalFrames)
			//color_txt.text = "";
			_mc.affiliate_txt.text = $evt.target.name;
			// this[$evt.target.name].addEventListener( MouseEvent.MOUSE_OUT, _onOut_handler, false, 0, true );
			$evt.currentTarget.gotoAndPlay("ROLL_OVER_START");
		};
		
		private function _onOut_handler( $evt:MouseEvent ):void
		{
			_mc.affiliate_txt.text = _currentView;
			$evt.currentTarget.gotoAndPlay("ROLL_OUT_START");
		};
		
		//private function _onOver2_handler( $evt:MouseEvent ):void
		//{
		//	affiliate_txt.text = "";
		//	color_txt.htmlText = "<font color='"+_hexColors[ProgramlandSecurity[$evt.target.name.toUpperCase()]]+"'>" + $evt.target.name + "</font>";
		//	this[$evt.target.name].addEventListener( MouseEvent.MOUSE_OUT, _onOut2_handler, false, 0, true );
		//};
		//
		//private function _onOut2_handler( $evt:MouseEvent ):void
		//{
		//	color_txt.text = _currentView;
		//};
		
		private function _setDevName($s:String):TextField
		{
			var lbl:TextField = new TextField();
			/*lbl.text = $s.toUpperCase();*/
			lbl.text = $s;
			lbl.autoSize = TextFieldAutoSize.LEFT;
			lbl.selectable = false;
			var fmt:TextFormat = new TextFormat();
			/*fmt.font = "PillAlt600mg-Thin";*/
			fmt.font = "Helvetica";
			fmt.color = 0x000000;
			fmt.size = 21;
			/*fmt.letterSpacing = .5;*/
			/*fmt.bold = true;*/
			lbl.setTextFormat(fmt);
			return lbl;
		};
		
		
		private function _onContentComplete($e:Event = null):void
		{
			// Out.info( this, "_urlloader.data: " + _urlloader.data );
			_content = new XML(_urlloader.data);
			_urlloader = null;
			_init();
		};
	};
};