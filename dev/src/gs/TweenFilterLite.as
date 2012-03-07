/*
VERSION: 3.9
DATE: 7/31/2007
ACTIONSCRIPT VERSION: 3.0 (AS2 version is available)
UPDATES AT: http://www.TweenFilterLite.com (has link to AS3 version)
DESCRIPTION:
	TweenFilterLite extends the extremely lightweight (2k), powerful TweenLite "core" class, adding the ability to tween filters (like blurs, 
	glows, drop shadows, bevels, etc.) as well as image effects like contrast, colorization, brightness, saturation, hue, and threshold (combined size: 5k). 
	The syntax is identical to the TweenLite class. If you're unfamiliar with TweenLite, I'd highly recommend that you check it out. 
	It provides easy way to tween multiple object properties over time including a MovieClip's position, alpha, volume, color, etc. 
	Just like the TweenLite class, TweenFilterLite allows you to build in a delay, call any function when the tween starts or has completed
	(even passing any number of parameters you define), automatically kill other tweens that are affecting the same object (to avoid conflicts),
	tween arrays, etc. One of the big benefits of this class (and the reason "Lite" is in the name) is that it was carefully built to 
	minimize file size. There are several other Tweening engines out there, but in my experience, they required more than triple the 
	file size which was unacceptable when dealing with strict file size requirements (like banner ads). I haven't been able to find a 
	faster tween engine either. The syntax is simple and the class doesn't rely on complicated prototype alterations that can cause 
	problems with certain compilers. TweenFilterLite is simple, very fast, and more lightweight (5k) than any other popular tweening engine.

ARGUMENTS:
	1) mc: Target DisplayObject (typically a MovieClip or Sprite) whose properties we're tweening
	2) duration: Duration (in seconds) of the effect
	3) vars: An object containing the end values of all the properties you'd like to have tweened (or if you're using the 
	      	 TweenFilterLite.from() method, these variables would define the BEGINNING values). Examples are: blurX, blurY, contrast,
		  	 color, distance, colorize, brightness, highlightAlpha, etc. Make sure you define a type property. Possible value are:
		  	 "blur", "glow", "dropShadow", "bevel", and "color". (see below for more specifics)
		        SPECIAL PROPERTIES: 
				  volume: To change a MovieClip's volume, just set this to the value you'd like the MovieClip to
						  end up at (or begin at if you're using TweenLite.from()).
				  mcColor: To change a MovieClip's color, set this to the hex value of the color you'd like the MovieClip
						   to end up at(or begin at if you're using TweenLite.from()). An example hex value would be 0xFF0000
				  ease: You can specify a function to use for the easing with this variable. For example, 
						gs.core.easing.Elastic.easeOut. The Default is Regular.easeOut (and Linear.easeNone for volume).
				  onStart: If you'd like to call a function as soon as the tween begins, pass in a reference to it here.
						   This is useful for when there's a delay. 
				  onStartParams: An array of parameters to pass the onStart function. (this is optional)
				  onComplete: If you'd like to call a function when the tween has finished, use this. 
				  onCompleteParams: An array of parameters to pass the onComplete function (this is optional)
				  overwrite: If you do NOT want the tween to automatically overwrite any other tweens that are 
							 affecting the same target, make sure this value is false.
	4) delay: **DEPRECATED** [optional] Amount of delay before the tween should begin (in seconds). As of version 3.0, this 
						     has been deprecated - use the "delay" property of vars like TweenFilterLite.to(mc, 1, {type:"blur", blurX:10, delay:3.5});
	5) onComplete: **DEPRECATED** [optional] A reference to a function that you'd like to call as soon as this tween is complete.
						  		  As of version 3.0, this has been deprecated - use the "onComplete" property of vars like 
						  		  TweenFilterLite.to(mc, 1, {type:"blur", blurX:10, onComplete:onFinishTween});
	6) onCompleteParams: **DEPRECATED** [optional] An array of parameters to pass the onComplete function when this tween is finished.
									    As of version 3.0, this has been deprecated - use the "onCompleteParams" property of vars like 
									    TweenFilterLite.to(mc, 1, {type:"blur", blurX:10, onComplete:onFinishTween, onCompleteParams:[1, mc]});
	7) overwrite: **DEPRECATED** [optional] Unless this is specifically defined as false, all other tweens that are affecting the 
								 target are deleted. It is used to prevent collisions with other tweens. If you know there won't 
								 be any collisions, you can pass false in order to speed things up slightly. As of version 3.0, 
								 this has been deprecated - use the "overwrite" property of vars like TweenFilterLite.to(mc, 1, {type:"blur", blurX:10, overwrite:false});
	
FITLERS & PROPERTIES:
	type:"blur"
		Possible properties: blurX, blurY, quality
		
	type:"glow"
		Possible properties: alpha, blurX, blurY, color, strength, quality
	
	type:"color"
		Possible properties: colorize, amount, contrast, brightness, saturation, hue, threshold, relative
	
	type:"dropShadow"
		Possible properties: alpha, angle, blurX, blurY, color, distance, strength, quality
	
	type:"bevel"
		Possible properties: angle, blurX, blurY, distance, highlightAlpha, highlightColor, shadowAlpha, shadowColor, strength, quality
	

EXAMPLES: 
	As a simple example, you could tween the blur of clip_mc from where it's at now to 20 over the course of 1.5 seconds by:
		
		import gs.TweenFilterLite;
		TweenFilterLite.to(clip_mc, 1.5, {type:"blur", blurX:20, blurY:20});
	
	To set up a sequence where we colorize a MovieClip red over the course of 2 seconds, and then blur it over the course of 1 second,:
	
		import gs.TweenFilterLite;
		TweenFilterLite.to(clip_mc, 1, {type:"color", colorize:0xFF0000, amount:1});
		TweenFilterLite.to(clip_mc, 2, {type:"blur", blurX:20, blurY:20, delay:3, overwrite:false});
		
	If you want to get more advanced and tween the clip_mc MovieClip over 5 seconds, changing the saturation to 0, 
	delay starting the whole tween by 2 seconds, and then call a function named "onFinishTween" when it has 
	completed and pass in a few arguments to that function (a value of 5 and a reference to the clip_mc), you'd 
	do so like:
		
		import gs.TweenFilterLite;
		import fl.motion.easing.Back;
		TweenFilterLite.to(clip_mc, 5, {type:"color", saturation:0, delay:2, onComplete:onFinishTween, onCompleteParams:[5, clip_mc]});
		function onFinishTween(argument1_num:Number, argument2_mc:MovieClip):Void {
			trace("The tween has finished! argument1_num = " + argument1_num + ", and argument2_mc = " + argument2_mc);
		}
	
	If you have a MovieClip on the stage that already has the properties you'd like to end at, and you'd like to 
	start with a colorized version (red: 0xFF0000) and tween to the current properties, you could:
		
		import gs.TweenFilterLite;
		TweenFilterLite.from(clip_mc, 5, {type:"color", colorize:0xFF0000});		
	

NOTES:
	- This class (along with the TweenLite class which it extends) will add about 6kb total to your Flash file.
	- Requires that you target Flash 9 Player or later (ActionScript 3.0).
	- Instead of using "100" as the base number for most values (like brightness, contrast, saturation, etc.) like the ActionScript 2.0 
	  version of this class did, we now use "1" in order to be consistent with the rest of ActionScript 3.0.
	- Quality defaults to a level of "2" for all filters, but you can pass in a value to override it.
	- This class requires the gs.TweenLite class.
	- The image filter (type:"color") functions were built so that you can leverage this class to manipulate matrixes for the
	  ColorMatrixFilter by calling the static functions directly (so you don't necessarily have to be tweening 
	  anything). For example, you could colorize a matrix by:
	  var myNewMatrix_array = TweenFilterLite.colorize(myOldMatrix_array, 0xFF0000, 100);
	- Special thanks to Mario Klingemann (http://www.quasimondo.com) for the work he did on his ColorMatrix class.
	  It was very helpful for the image effects.

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2007, GreenSock (This work is subject to the terms in http://www.greensock.com/terms_of_use.html.)
*/

package gs {
	import gs.TweenLite;
	import flash.filters.*;
	import flash.display.DisplayObject;
	import flash.utils.getTimer;
	
	public class TweenFilterLite extends TweenLite {
		var _matrix:Array;
		private var _mc:DisplayObject;
		private var _f:Object; //Filter
		private var _fType:*;
		private var _clrsa:Array; //Array that pertains to any color properties (like "color", "highlightColor", "shadowColor", etc.)
		private var _endMatrix:Array;
		private var _clrMtxTw:TweenLite; //The tween that's handling the Color Matrix Filter (if any)
		private static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
		private static var _lumR:Number = 0.212671; //Red constant - used for a few color matrix filter functions
		private static var _lumG:Number = 0.715160; //Green constant - used for a few color matrix filter functions
		private static var _lumB:Number = 0.072169; //Blue constant - used for a few color matrix filter functions
		
		public function TweenFilterLite(mc:DisplayObject, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true) {
			super(mc, duration, vars, delay, onComplete, onCompleteParams, false); //We always pass ao as false because the variables like _matrix, _f, etc. wouldn't be able to be attached to a hijacked TweenLite instance and we'd run into problems.
			if (overwrite != false && vars.overwrite != false && mc != null) { //Without this block of code, we'd run into cases where a TweenLite with the same target was found & hijacked in place of this one (in the super() constructor), but all the variables were attached to THIS instance (like _matrix, etc.) instead of the hijacked one.
				var fa:Array = TweenLite.allTweens_array.slice();
				for (var i:int = fa.length - 1; i >= 0; i--) {
					if (fa[i].endTarget_obj == mc && fa[i] != this && fa[i].target_obj != this && !fa[i].dead_bol) {
						removeTween(fa[i]);
					}
				}
			}
			endTarget_obj = mc;
			_mc = mc;
			if (vars_obj.quality == undefined || isNaN(vars_obj.quality)) {
				vars_obj.quality = 2;
			}
			if (vars.reverse == true) {
				initTweenVals();
			}
		}
		
		public static function to(mc:DisplayObject, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true):TweenFilterLite {
			return new TweenFilterLite(mc, duration, vars, delay, onComplete, onCompleteParams, overwrite);
		}
		
		//This function really helps if there are MovieClips whose filters we want to animate into place (they are already in their end state on the stage for example). 
		public static function from(mc:DisplayObject, duration:Number, vars:Object, delay:Number = 0, onComplete:Function = null, onCompleteParams:Array = null, overwrite:Boolean = true):TweenFilterLite {
			vars.reverse = true;
			return new TweenFilterLite(mc, duration, vars, delay, onComplete, onCompleteParams, overwrite);
		}
		
		override public function initTweenVals():void {
			if (vars_obj.type != null && _mc != null) {
				super.initTweenVals();
				var i:int;
				_clrsa = [];
				_matrix = _idMatrix.slice();
				if (vars_obj.reverse == true) {
					for (i = 0; i < tween_array.length; i++) {
						tween_array[i].reversed = true; //Gives us a way to identify the tweens that were already reversed in the initTweenVals() call. We only need to reverse the new ones we're adding below (later)...
					}
				}
				switch(vars_obj.type.toLowerCase()) {
					case "blur":
						setFilter(BlurFilter, ["blurX", "blurY", "quality"], new BlurFilter(0, 0, vars_obj.quality));
						break;
					case "glow":
						setFilter(GlowFilter, ["alpha", "blurX", "blurY", "color", "quality", "strength"], new GlowFilter(0xFFFFFF, 0, 0, 0, 1, vars_obj.quality));
						break;
					case "colormatrix":
					case "color":
					case "colormatrixfilter":
					case "colorize":
						setFilter(ColorMatrixFilter, [], new ColorMatrixFilter(_matrix));
						_matrix = _f.matrix;
						if (vars_obj.relative == true) {
							_endMatrix = _matrix.slice();
						} else {
							_endMatrix = _idMatrix.slice();
						}
						_endMatrix = setBrightness(_endMatrix, vars_obj.brightness);
						_endMatrix = setContrast(_endMatrix, vars_obj.contrast);
						_endMatrix = setHue(_endMatrix, vars_obj.hue);
						_endMatrix = setSaturation(_endMatrix, vars_obj.saturation);
						_endMatrix = setThreshold(_endMatrix, vars_obj.threshold);
						if (!isNaN(vars_obj.colorize)) {
							_endMatrix = colorize(_endMatrix, vars_obj.colorize, vars_obj.amount);
						} else if (!isNaN(vars_obj.color)) { //Just in case they define "color" instead of "colorize"
							_endMatrix = colorize(_endMatrix, vars_obj.color, vars_obj.amount);
						}
						var ndl = delay_num - ((getTimer() - initTime_num) / 1000); //new delay. We need this because reversed (TweenLite.from() calls) need to maintain the delay in any sub-tweens (like for color or volume tweens) but normal TweenLite.to() tweens should have no delay because this function gets called only when the begin!
						_clrMtxTw = new TweenLite(_matrix, duration_num, {endMatrix:_endMatrix, ease:vars_obj.ease, delay:ndl, overwrite:false, reverse:vars_obj.reverse});
						_clrMtxTw.endTarget_obj = _mc;
						
						var twa = TweenLite.allTweens_array;
						twa.splice(-1, 1);
						for (i = twa.length - 1; i >= 0; i--) {
							if (twa[i] == this) {
								twa.splice(i, 0, _clrMtxTw);
							}
						}
						break;
					case "shadow":
					case "dropshadow":
						setFilter(DropShadowFilter, ["alpha", "angle", "blurX", "blurY", "color", "distance", "quality", "strength"], new DropShadowFilter(0, 45, 0x000000, 0, 0, 0, 1, vars_obj.quality));
						break;
					case "bevel":
						setFilter(BevelFilter, ["angle", "blurX", "blurY", "distance", "highlightAlpha", "highlightColor", "quality", "shadowAlpha", "shadowColor", "strength"], new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0x000000, 0.5, 2, 2, 0, vars_obj.quality));
						break;
				}
				if (vars_obj.reverse == true) {
					var tp;
					for (i = 0; i < tween_array.length; i++) {
						if (tween_array[i].reversed != true) {
							tp = tween_array[i];
							tp.s += tp.c;
							tp.c *= -1;
							tp.o[tp.p] = tp.e(0, tp.s, tp.c, duration_num);
							tp.reversed = true;
						}
					}
					flipFilterVals();
				}
			}
		}
		
		private function setFilter(filterType:Class, props:Array, defaultFilter:Object):void {
			_fType = filterType;
			var fltrs = _mc.filters;
			var found = false;
			var i:int;
			for (i = 0; i < fltrs.length; i++) {
				if (fltrs[i] is filterType) {
					_f = fltrs[i];
					found = true;
					break;
				}
			}
			if (!found) {
				fltrs.push(defaultFilter);
				_mc.filters = fltrs;
				_f = defaultFilter;
			}
			var prop:String;
			var filterProp:String;
			var p:int;
			for (i = tween_array.length - 1; i >= 0; i--) {
				prop = tween_array[i].p.toLowerCase();
				if (prop == "brightness" || prop == "colorize" || prop == "amount" || prop == "saturation" || prop == "contrast" || prop == "hue" || prop == "threshold") {
					tween_array.splice(i, 1);
				} else {
					for (p = 0; p < props.length; p++) {
						if (prop == props[p].toLowerCase()) {
							filterProp = props[p];
							if (filterProp == "color" || filterProp == "highlightColor" || filterProp == "shadowColor") {
								var start_obj = HEXtoRGB(_f[filterProp]);
								var end_obj = HEXtoRGB(vars_obj[tween_array[i].p]);
								_clrsa.push({p:filterProp, e:vars_obj.ease, sr:start_obj.rb, cr:end_obj.rb - start_obj.rb, sg:start_obj.gb, cg:end_obj.gb - start_obj.gb, sb:start_obj.bb, cb:end_obj.bb - start_obj.bb});
								tween_array.splice(i, 1);
							} else if (filterProp == "quality") {
								_f.quality = vars_obj[tween_array[i].p];
								tween_array.splice(i, 1);
							} else {
								tween_array[i] = {o:_f, p:filterProp, s:_f[filterProp], c:vars_obj[tween_array[i].p] - _f[filterProp], e:vars_obj.ease};
							}
							break;
						}
					}
				}
			}
			
		}
		
		public function flipFilterVals():void {
			var active = this.active_bol;
			var i:int;
			var r:Number;
			var g:Number;
			var b:Number;
			var tp:Object;
			for (i = 0; i < _clrsa.length; i++) {
				tp = _clrsa[i];
				tp.sr += tp.cr;
				tp.cr *= -1;
				tp.sg += tp.cg;
				tp.cg *= -1;
				tp.sb += tp.cb;
				tp.cb *= -1;
				if (!active) {
					r = tp.e(0, tp.sr, tp.cr, duration_num);
					g = tp.e(0, tp.sg, tp.cg, duration_num);
					b = tp.e(0, tp.sb, tp.cb, duration_num);
					_f[tp.p] = (r << 16 | g << 8 | b); //Translates RGB to HEX
				}
			}
			if (active) {
				render();
			} else {
				if (_endMatrix != null) {
					_f.matrix = _matrix;
				}
				var f = _mc.filters;
				var nf = [];
				for (i = 0; i < f.length; i++) {
					if (f[i] is _fType) {
						nf.push(_f);
					} else {
						nf.push(f[i]);
					}
				}
				_mc.filters = nf;
			}
		}
	
		override public function render():void {
			var time = (getTimer() - startTime_num) / 1000;
			var i:int;
			var tp:Object; //Tweening property
			if (time > duration_num) {
				time = duration_num;
			}
			for (i = 0; i < tween_array.length; i++) {
				tp = tween_array[i];
				tp.o[tp.p] = tp.e(time, tp.s, tp.c, duration_num);
			}
			var r:Number;
			var g:Number;
			var b:Number;
			for (i = 0; i < _clrsa.length; i++) {
				tp = _clrsa[i];
				r = tp.e(time, tp.sr, tp.cr, duration_num);
				g = tp.e(time, tp.sg, tp.cg, duration_num);
				b = tp.e(time, tp.sb, tp.cb, duration_num);
				_f[tp.p] = (r << 16 | g << 8 | b); //Translates RGB to HEX
			}
			if (_endMatrix) {
				_f.matrix = _matrix;
			}
			var f = _mc.filters;
			var nf = [];
			for (i = 0; i < f.length; i++) {
				if (f[i] is _fType) {
					nf.push(_f);
				} else {
					nf.push(f[i]);
				}
			}
			_mc.filters = nf;
			//Check to see if we're done
			if (time >= duration_num) {
				dead_bol = true; //This is necessary in cases where the onComplete_func function we're about to call spawns a new TweenLite with the same _tg (target object) in which case it would try to hijack it and then when we call removeTween() below, it kills that next TweenLite. This allows us to keep track of when a TweenLite is marked for destruction and we check for this variable before hijacking (we won't hijack one that's marked for destruction).
				if (onComplete_func != null) {
					onComplete_func.apply(null, onCompleteParams_array);
				}
				if (_clrMtxTw != null) {
					removeTween(_clrMtxTw);
				}
				removeTween(this);
			}
		}
		
		public function HEXtoRGB(n:Number):Object {
			return {rb:n >> 16, gb:(n >> 8) & 0xff, bb:n & 0xff};
		}
		
	//---- COLOR MATRIX FILTER FUNCTIONS ---------------------------------------------------------------------------
		
		public static function colorize(m:Array, color:Number, amount:Number = 100):Array { //You can use 
			if (isNaN(color)) {
				return m;
			} else if (isNaN(amount)) {
				amount = 1;
			}
			var r:Number = ((color >> 16) & 0xff) / 255;
			var g:Number = ((color >> 8)  & 0xff) / 255;
			var b:Number = (color         & 0xff) / 255;
			var inv:Number = 1 - amount;
			var temp =  [inv + amount * r * _lumR, amount * r * _lumG,       amount * r * _lumB,       0, 0,
						 amount * g * _lumR,       inv + amount * g * _lumG, amount * g * _lumB,       0, 0,
						 amount * b * _lumR,       amount * b * _lumG,       inv + amount * b * _lumB, 0, 0,
						 0, 				       0, 					     0, 					   1, 0];		
			return applyMatrix(temp, m);
		}
		
		public static function setThreshold(m:Array, n:Number):Array {
			if (isNaN(n)) {
				return m;
			}
			var temp = [_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * n, 
						_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * n, 
						_lumR * 256, _lumG * 256, _lumB * 256, 0,  -256 * n, 
						0,           0,           0,           1,  0]; 
			return applyMatrix(temp, m);
		}
		
		public static function setHue(m:Array, n:Number):Array {
			if (isNaN(n)) {
				return m;
			}
			n *= Math.PI / 180;
			var c = Math.cos(n);
			var s = Math.sin(n);
			var temp = [(_lumR + (c * (1 - _lumR))) + (s * (-_lumR)), (_lumG + (c * (-_lumG))) + (s * (-_lumG)), (_lumB + (c * (-_lumB))) + (s * (1 - _lumB)), 0, 0, (_lumR + (c * (-_lumR))) + (s * 0.143), (_lumG + (c * (1 - _lumG))) + (s * 0.14), (_lumB + (c * (-_lumB))) + (s * -0.283), 0, 0, (_lumR + (c * (-_lumR))) + (s * (-(1 - _lumR))), (_lumG + (c * (-_lumG))) + (s * _lumG), (_lumB + (c * (1 - _lumB))) + (s * _lumB), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
			return applyMatrix(temp, m);
		}
		
		public static function setBrightness(m:Array, n:Number):Array {
			if (isNaN(n)) {
				return m;
			}
			n = (n * 100) - 100;
			return applyMatrix([1,0,0,0,n,
								0,1,0,0,n,
								0,0,1,0,n,
								0,0,0,1,0,
								0,0,0,0,1], m);
		}
		
		public static function setSaturation(m:Array, n:Number):Array {
			if (isNaN(n)) {
				return m;
			}
			var inv = 1 - n;
			var r = inv * _lumR;
			var g = inv * _lumG;
			var b = inv * _lumB;
			var temp = [r + n, g    , b    , 0, 0,
						r    , g + n, b    , 0, 0,
						r    , g    , b + n, 0, 0,
						0    , 0    , 0    , 1, 0];
			return applyMatrix(temp, m);
		}
		
		public static function setContrast(m:Array, n:Number):Array {
			if (isNaN(n)) {
				return m;
			}
			n += 0.01;
			var temp:Array =  [n,0,0,0,128 * (1 - n),
							   0,n,0,0,128 * (1 - n),
							   0,0,n,0,128 * (1 - n),
							   0,0,0,1,0];
			return applyMatrix(temp, m);
		}
		
		public static function applyMatrix(m:Array, m2:Array):Array {
			if (!(m is Array) || !(m2 is Array)) {
				return m2;
			}
			var temp:Array = [];
			var i:int = 0;
			var z:int = 0;
			var y:int;
			var x:int;
			for (y = 0; y < 4; y++) {
				for (x = 0; x < 5; x++) {
					if (x == 4) {
						z = m[i + 4];
					} else {
						z = 0;
					}
					temp[i + x] = m[i]   * m2[x]      + 
								  m[i+1] * m2[x + 5]  + 
								  m[i+2] * m2[x + 10] + 
								  m[i+3] * m2[x + 15] +
								  z;
				}
				i += 5;
			}
			return temp;
		}
	}
}