/*
VERSION: 3.9
DATE: 7/30/2007
ACTIONSCRIPT VERSION: 3.0 (AS2 version is also available)
UPDATES AT: http://www.TweenLite.com (there's a link to the AS3 version)
DESCRIPTION:
	TweenLite provides a lightweight (about 2k), easy way to tween almost any property of any object over time including 
	a MovieClip's volume and color. You can easily tween multiple properties at the same time. You can even tween arrays. 
	There are advanced features that allow you to build in a delay, call any function when the tween has completed (even 
	passing any number of parameters you define), automatically kill other tweens that are affecting the same object 
	(to avoid conflicts), etc. One of the big benefits of this class (and the reason "Lite" is in the name) is that it was 
	carefully built to minimize file size. There are several other Tweening engines out there, but in my experience, they 
	required more than triple the file size which was unacceptable when dealing with strict file size requirements 
	(like banner ads). I haven't been able to find a faster tween engine either. The syntax is simple and the class doesn't 
	rely on complicated prototype alterations that can cause problems with certain compilers. TweenLite is simple, very fast, 
	and more lightweight than any other popular tweening engine.

ARGUMENTS:
	1) target: Target MovieClip (or any other object) whose properties we're tweening
	2) duration: Duration (in seconds) of the effect
	3) vars: An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
	         TweenLite.from() method, these variables would define the BEGINNING values). For example:
					  alpha: The alpha (opacity level) that the target object should finish at (or begin at if you're 
							 using TweenLite.from()). For example, if the target_obj.alpha is 1 when this script is 
					  		 called, and you specify this argument to be 0.5, it'll transition from 1 to 0.5.
					  x: To change a MovieClip's x position, just set this to the value you'd like the MovieClip to 
					     end up at (or begin at if you're using TweenLite.from()). 
				  SPECIAL PROPERTIES:
					  volume: To change a MovieClip's volume, just set this to the value you'd like the MovieClip to
					          end up at (or begin at if you're using TweenLite.from()).
					  mcColor: To change a MovieClip's color, set this to the hex value of the color you'd like the MovieClip
					  		   to end up at(or begin at if you're using TweenLite.from()). An example hex value would be 0xFF0000
					  ease: You can specify a function to use for the easing with this variable. For example, 
					        fl.motion.easing.Elastic.easeOut. The Default is Regular.easeOut (and Linear.easeNone for volume).
					  onStart: If you'd like to call a function as soon as the tween begins, pass in a reference to it here.
					  		   This is useful for when there's a delay. 
					  onStartParams: An array of parameters to pass the onStart function.
					  onComplete: If you'd like to call a function when the tween has finished, use this. 
					  onCompleteParams: An array of parameters to pass the onComplete function
					  overwrite: If you do NOT want the tween to automatically overwrite any other tweens that are 
					             affecting the same target, make sure this value is false.
	4) delay: **DEPRECATED** [optional] Amount of delay before the tween should begin (in seconds). As of version 3.0, this 
						     has been deprecated - use the "delay" property of vars like TweenLite.to(mc, 1, {x:20, delay:3.5});
	5) onComplete: **DEPRECATED** [optional] A reference to a function that you'd like to call as soon as this tween is complete.
						  		  As of version 3.0, this has been deprecated - use the "onComplete" property of vars like 
						  		  TweenLite.to(mc, 1, {x:20, onComplete:onFinishTween});
	6) onCompleteParams: **DEPRECATED** [optional] An array of parameters to pass the onComplete function when this tween is finished.
									    As of version 3.0, this has been deprecated - use the "onCompleteParams" property of vars like 
									    TweenLite.to(mc, 1, {x:20, onComplete:onFinishTween, onCompleteParams:[1, mc]});
	7) overwrite: **DEPRECATED** [optional] Unless this is specifically defined as false, all other tweens that are affecting the 
								 target are deleted. It is used to prevent collisions with other tweens. If you know there won't 
								 be any collisions, you can pass false in order to speed things up slightly. As of version 3.0, 
								 this has been deprecated - use the "overwrite" property of vars like TweenLite.to(mc, 1, {x:20, overwrite:false});
	

EXAMPLES: 
	As a simple example, you could tween the alpha to 50% (0.5) and move the x position of a MovieClip named "clip_mc" 
	to 120 and fade the volume to 0 over the course of 1.5 seconds like so:
	
		import gs.TweenLite;
		TweenLite.to(clip_mc, 1.5, {alpha:0.5, x:120, volume:0});
	
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the alpha to 0.5, 
	the x to 120 using the "easeOutBack" easing function, delay starting the whole tween by 2 seconds, and then call
	a function named "onFinishTween" when it has completed and pass in a few parameters to that function (a value of
	5 and a reference to the clip_mc), you'd do so like:
		
		import gs.TweenLite;
		import fl.motion.easing.Back;
		TweenLite.to(clip_mc, 5, {alpha:0.5, x:120, ease:Back.easeOut, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1:Number, argument2:MovieClip):void {
			trace("The tween has finished! argument1 = " + argument1 + ", and argument2 = " + argument2);
		}
	
	If you have a MovieClip on the stage that is already in it's end position and you just want to animate it into 
	place over 5 seconds (drop it into place by changing its y property to 100 pixels higher on the screen and 
	dropping it from there), you could:
		
		import gs.TweenLite;
		import fl.motion.easing.Elastic;
		TweenLite.from(clip_mc, 5, {y:clip_mc.y - 100, ease:Elastic.easeOut});		
	

NOTES:
	- This class will add about 2kb to your Flash file.
	- You must target Flash Player 9 or later (ActionScript 3.0)
	- You can tween the volume of any MovieClip using the tween property "volume", like:
	  TweenLite.to(myClip_mc, 1.5, {volume:0});
	- You can tween the color of a MovieClip using the tween property "mcColor", like:
	  TweenLite.to(myClip_mc, 1.5, {mcColor:0xFF0000});
	- To tween an array, just pass in an array as a property (it doesn't matter what you name it) like:
	  var myArray_array = [1,2,3,4];
	  TweenLite.to(myArray_array, 1.5, {end_array:[10,20,30,40]});
	- You can kill all tweens for a particular object (usually a MovieClip) anytime with the 
	  TweenLite.killTweensOf(myClip_mc); function.
	- You can kill all delayedCalls to a particular function using TweenLite.killDelayedCallsTo(myFunction_func);
	  This can be helpful if you want to preempt a call.
	- Use the TweenLite.from() method to animate things into place. For example, if you have things set up on 
	  the stage in the spot where they should end up, and you just want to animate them into place, you can 
	  pass in the beginning x and/or y and/or alpha (or whatever properties you want).

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2007, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

package gs {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.media.SoundTransform;
	import flash.geom.ColorTransform;

	public class TweenLite {
		private static var _sprite_spr:Sprite = new Sprite(); //A reference to the sprite that we use to drive all our ENTER_FRAME events.
		private static var _listening_bol:Boolean; //If true, the ENTER_FRAME is being listened for (there are tweens that are in the queue)
		private static var _all:Array = new Array(); //Holds references to all our tweens.
		private static var _delayedCall_obj:Object = new Object(); //Just a generic object that we use as the target for all delayedCall() calls.
		private var _active_bol:Boolean; //If true, this tween is active. 
		
		var duration_num:Number; //Duration (in seconds)
		var vars_obj:Object; //Variables (holds things like _alpha or _y or whatever we're tweening)
		var delay_num:Number; //Delay (in seconds)
		var onComplete_func:Function; //The function that should be triggered when this tween has completed
		var onCompleteParams_array:Array; //An array containing the parameters that should be passed to the onComplete_func when this tween has finished.
		var onStart_func:Function; //The function that should be triggered when the tween starts (useful when there's a delay)
		var onStartParams_array:Array; //An array containing the parameters that should be passed to the onStart_func
		var startTime_num:uint; //Start time
		var initTime_num:uint; //Time of initialization. Remember, we can build in delays so this property tells us when the frame action was born, not when it actually started doing anything.
		var tween_array:Array; //Contains parsed data for each property that's being tweened (each has to have a taget_obj, endTarget_obj, start_num, a change_num, and an ease).
		var sound_obj:SoundTransform; //We only use this in cases where the user wants to change the volume of a MovieClip (they pass in a "volume" property in the v)
		var dead_bol:Boolean; //If true, this TweenLite is marked for destruction, so don't hijack it.
		var target_obj:Object; //Target object (usually a MovieClip)
		var endTarget_obj:Object; //End target. It's almost always the same as target_obj except for volume and color tweens. It helps us to see what object or MovieClip the tween really pertains to (so that we can killTweensOf() properly and hijack auto-overwritten ones)
		var color_obj:ColorTransform;
		var endColor_obj:ColorTransform; 
		var instance_obj:TweenLite; //Useful for when a TweenLite gets instantiated but hijacks a pre-existing one (overwrites it). The instance_obj will always point to the active TweenLite. We use this in the from() method.
		
		public function TweenLite(target:Object, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true) {
			var tl:TweenLite = this; //Default value. We swap this out if we the auto-overwrite is true and we find another TweenLite that's controling the same target object.
			var found:Boolean = false;
			var i:int; //For looping
			if (vars.overwrite != false && overwrite != false && target != null) { //We used to just call killTweensOf(target), but rewrote slightly lengthier code here to basically hijack the first existing tween we find for the object because it runs much faster and avoids extra loops later.
				var fa:Array = _all.slice();
				for (i = fa.length - 1; i >= 0; i--) {
					if (fa[i].endTarget_obj == target && !fa[i].dead_bol) {
						if (!found) {
							tl = fa[i];		
							found = true;
						} else {
							removeTween(fa[i]);
						}
					}
				}
			}
			tl.dead_bol = false;
			tl.target_obj = tl.endTarget_obj = target;
			tl.duration_num = duration;
			tl.vars_obj = vars;
			tl.onComplete_func = vars.onComplete || onComplete;
			tl.onCompleteParams_array = vars.onCompleteParams || onCompleteParams;
			tl.onStart_func = vars.onStart;
			tl.onStartParams_array = vars.onStartParams;
			tl.delay_num = vars.delay || delay;
			if (tl.delay_num == 0) {
				tl.startTime_num = getTimer();
				if (tl.onStart_func != null) {
					tl.onStart_func.apply(null, tl.onStartParams_array);
				}
			}
			if (tl.vars_obj.ease == undefined) {
				tl.vars_obj.ease = easeOut;
			} else if (!(tl.vars_obj.ease is Function)) {
				trace("ERROR: You cannot use '" + tl.vars_obj.ease + "' for the TweenLite ease property. Only functions are accepted.");
			}
			tl.tween_array = [];
			tl.initTime_num = getTimer();
			if (tl.vars_obj.reverse == true) {
				tl.initTweenVals();
			}
			instance_obj = tl;
			if (!found) {
				_all.push(tl);
				if (!_listening_bol) {
					_sprite_spr.addEventListener(Event.ENTER_FRAME, executeAll);
					_listening_bol = true;
				}
			}
		}
		
		public function initTweenVals():void {
			var ndl = delay_num - ((getTimer() - initTime_num) / 1000); //new delay. We need this because reversed (TweenLite.from() calls) need to maintain the delay in any sub-tweens (like for color or volume tweens) but normal TweenLite.to() tweens should have no delay because this function gets called only when the begin!
			var p:String; //For looping (for p in obj)
			if (target_obj is Array) {
				var endArray = [];
				for (p in vars_obj) { //First find an instance of an array in the vars_obj to match up with. There should never be more than one.
					if (vars_obj[p] is Array) {
						endArray = vars_obj[p];
						break;
					}
				}
				for (i = 0; i < endArray.length; i++) {
					if (target_obj[i] != endArray[i] && target_obj[i] != undefined) {
						tween_array.push({o:target_obj, p:i.toString(), s:target_obj[i], c:endArray[i] - target_obj[i], e:vars_obj.ease}); //o: object, p:property, s:starting value, c:change in value, e: easing function
					}
				}
			} else {
				for (p in vars_obj) {
					if (p == "volume" && target_obj is MovieClip) { //If we're trying to change the volume of a MovieClip, then set up a quasai proxy using an instance of a TweenLite to control the volume.
						sound_obj = target_obj.soundTransform;
						var volTween = new TweenLite(this, duration_num, {volumeProxy:vars_obj[p], ease:easeNone, delay:ndl, overwrite:false, reverse:vars_obj.reverse});
						volTween.endTarget_obj = target_obj;
					} else if (p.toLowerCase() == "mccolor" && target_obj is MovieClip) { //If we're trying to change the color of a MovieClip, then set up a quasai proxy using an instance of a TweenLite to control the color.
						color_obj = target_obj.transform.colorTransform;
						endColor_obj = new ColorTransform();
						if (vars_obj.alpha != undefined) {
							endColor_obj.alphaMultiplier = vars_obj.alpha;
						} else {
							endColor_obj.alphaMultiplier = target_obj.alpha;
						}
						if (vars_obj[p] != null && vars_obj[p] != "") { //In case they're actually trying to remove the colorization, they should pass in null or "" for the mcColor
							endColor_obj.color = vars_obj[p];
						}
						var colorTween = new TweenLite(this, duration_num, {colorProxy:1, delay:ndl, overwrite:false, reverse:vars_obj.reverse});
						colorTween.endTarget_obj = target_obj;
					} else if (!isNaN(vars_obj[p]) && p != "delay" && p != "overwrite" && p != "reverse") {
						if (target_obj.hasOwnProperty(p)) {
							tween_array.push({o:target_obj, p:p, s:target_obj[p], c:vars_obj[p] - target_obj[p], e:vars_obj.ease}); //o: object, p:property, s:starting value, c:change in value, e: easing function
						} else {
							tween_array.push({o:target_obj, p:p, s:0, c:0, e:vars_obj.ease}); //Still populate the tween_array because TweenFilterLite may need it (like for blurX, blurY, and other filter properties)
						}
					}
				}
			}
			if (vars_obj.reverse == true) {
				var tp, i;
				for (i = 0; i < tween_array.length; i++) {
					tp = tween_array[i];
					tp.s += tp.c;
					tp.c *= -1;
					tp.o[tp.p] = tp.e(0, tp.s, tp.c, duration_num);
				}
			}
		}
		
		public static function to(target:Object, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true):TweenLite {
			return new TweenLite(target, duration, vars, delay, onComplete, onCompleteParams, overwrite);
		}
		
		//This function really helps if there are objects (usually MovieClips) that we just want to animate into place (they are already at their end position on the stage for example). 
		public static function from(target:Object, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true):TweenLite {
			vars.reverse = true;
			return new TweenLite(target, duration, vars, delay, onComplete, onCompleteParams, overwrite);;
		}
		
		public static function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array = null):TweenLite {
			return new TweenLite(_delayedCall_obj, 0, {delay:delay, onComplete:onComplete, onCompleteParams:onCompleteParams, overwrite:false});
		}
		
		public function render():void {
			var time:Number = (getTimer() - startTime_num) / 1000;
			if (time > duration_num) {
				time = duration_num;
			}
			var tp:Object;
			for (var i:int = 0; i < tween_array.length; i++) {
				tp = tween_array[i];
				tp.o[tp.p] = tp.e(time, tp.s, tp.c, duration_num);
			}
			if (time >= duration_num) { //Check to see if we're done
				dead_bol = true; //This is necessary in cases where the onComplete_func function we're about to call spawns a new TweenLite with the same target_obj (target object) in which case it would try to hijack it and then when we call removeTween() below, it kills that next TweenLite. This allows us to keep track of when a TweenLite is marked for destruction and we check for this variable before hijacking (we won't hijack one that's marked for destruction).
				if (onComplete_func != null) {
					onComplete_func.apply(null, onCompleteParams_array);
				}
				removeTween(this);
			}
			
		}
		
		public static function removeTween(t:TweenLite):void {
			for (var i:int = _all.length - 1; i >= 0; i--) {
				if (_all[i] == t) {
					killTweenAt(i);
					break;
				}
			}
		}
		
		public static function killDelayedCallsTo(f:Object):void {
			for (var i:int = _all.length - 1; i >= 0 ; i--) {
				if ((_all[i].onComplete_func == f && _all[i].target_obj == _delayedCall_obj) || _all[i].target_obj == f) { //Note: when you pass the killTweensOf a reference to a class, it's percieved as a function.
					killTweenAt(i);
				}
			}
		}
		
		public static function killTweensOf(tg:Object):void {
			if (tg is Function) {
				killDelayedCallsTo(tg);
			} else {
				for (var i:int = _all.length - 1; i >= 0 ; i--) {
					if (_all[i].endTarget_obj == tg) {
						killTweenAt(i);
					}
				}
			}
		}
		
		private static function killTweenAt(i:Number):void {
			delete _all[i];
			_all.splice(i, 1);
			if (_all.length == 0) {
				_sprite_spr.removeEventListener(Event.ENTER_FRAME, executeAll); //Frees up resources.
				_listening_bol = false;
			}
		}
		
		public static function executeAll(event:Event):void {
			var fa:Array = _all.slice(); //Another tween may get added to the _all array during the time it takes to complete this function in which case the new ones may get fired immediately. So we slice the array to ensure that we're just working with a copy of the original array that was in tact at the beginning of this function.
			var l:int = fa.length;
			for (var i:int = 0; i < l; i++) {
				if (fa[i].active_bol) {
					fa[i].render();
				}
			}
		}
		
		//Default ease function for tweens other than _alpha (Regular.easeOut)
		private static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * (t /= d) * (t - 2) + b;
		}
		//Default ease function for volume tweens
		private static function easeNone(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b;
		}
		
	//---- GETTERS / SETTERS -----------------------------------------------------------------------
		
		public function get active_bol():Boolean {
			if (_active_bol) {
				return true;
			} else if ((getTimer() - initTime_num) / 1000 > delay_num) {
				_active_bol = true;
				startTime_num = getTimer();
				if (vars_obj.reverse != true) {
					initTweenVals();
				}
				if (onStart_func != null) {
					onStart_func.apply(null, onStartParams_array);
				}
				if (duration_num == 0) { //We can't pass 0 to the easing function, otherwise it won't return the final value, so we pad it ever so slightly here and also adjust the startTime to compensate so that things are precise. We could do this in the render() function, but that would slow things down slightly since it's called on every frame. This way, we only evaluate this once and keep things speedy.
					duration_num = 0.001;
					startTime_num -= 1
				}
				return true;
			} else {
				return false;
			}
		}
		public function set volumeProxy(n:Number):void { //Used as a proxy of sorts to control the volume of the target MovieClip.
			sound_obj.volume = n;
			target_obj.soundTransform = sound_obj;
		}
		public function get volumeProxy():Number {
			return sound_obj.volume;
		}
		public function set colorProxy(n:Number):void { 
			var r = 1 - n;
			target_obj.transform.colorTransform = new ColorTransform(color_obj.redMultiplier * r + endColor_obj.redMultiplier * n,
																	  color_obj.greenMultiplier * r + endColor_obj.greenMultiplier * n,
																	  color_obj.blueMultiplier * r + endColor_obj.blueMultiplier * n,
																	  color_obj.alphaMultiplier * r + endColor_obj.alphaMultiplier * n,
																	  color_obj.redOffset * r + endColor_obj.redOffset * n,
																	  color_obj.greenOffset * r + endColor_obj.greenOffset * n,
																	  color_obj.blueOffset * r + endColor_obj.blueOffset * n,
																	  color_obj.alphaOffset * r + endColor_obj.alphaOffset * n);
		}
		public function get colorProxy():Number {
			return 0;
		}
		public static function get allTweens_array():Array {
			return _all;
		}
		
	}
	
}