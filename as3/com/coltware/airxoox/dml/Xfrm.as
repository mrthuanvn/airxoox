/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.dml {
	public class Xfrm {
		
		private var _offset_x:uint;
		private var _offset_y:uint;
		
		private var _width:uint;
		private var _height:uint;
		
		private var _scale_x:uint = 0;
		private var _scale_y:uint = 0;
		
		private var _scale_width:uint = 0;
		private var _scale_height:uint = 0;
		
		public function Xfrm(xml:XML) {
			init(xml);
		}
		
		private function init(xml:XML):void{
			var nsA:Namespace = xml.namespace("a");
			var off:XML = xml.nsA::off[0];
			_offset_x = uint(off.@x);
			_offset_y = uint(off.@y);
			
			var ext:XML = xml.nsA::ext[0];
			_width = uint(ext.@cx);
			_height = uint(ext.@cy);
		}
		
		public function get width():uint{
			return _width;
		}
		
		public function get height():uint{
			return _height;
		}
		
		public function get x():uint{
			return _offset_x;
		}
		
		public function get y():uint{
			return _offset_y;
		}
		
		public function get scale_x():uint{
			return _scale_x;
		}
		
		public function get scale_y():uint{
			return _scale_y;
		}
		
		public function get scale_width():uint{
			return _scale_width;
		}
		
		public function get scale_height():uint{
			return _scale_height;
		}
		
		public function setScale(x:uint,y:uint,w:uint,h:uint):void{
			_scale_x = x;
			_scale_y = y;
			_scale_width = w;
			_scale_height = h;
		}
		
		
		
		
		public function toString():String{
			var ret:String = 
					"[x,y][w,h] = [" + 
					_offset_x + "," +
					_offset_y + "][" + 
					_width + "," + 
					_height + "] =>" +
					"[sx,sy,sw,sh] = [" +
					_scale_x + "," +
					_scale_y + "][" + 
					_scale_width + "," + 
					_scale_height + "]"
					;
			return ret;
		}
	}

}