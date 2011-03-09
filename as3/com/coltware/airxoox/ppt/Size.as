/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt {
	public class Size {
		
		private var _cx:uint;
		private var _cy:uint;
		
		
		public function Size(cx:uint,cy:uint) {
			_cx = cx;
			_cy = cy;
		}
		
		public function get cx():uint{
			return _cx;
		}
		
		public function get cy():uint{
			return _cy;
		}
		
		public function toString():String{
			return "[x,y] = [" + _cx + "," + _cy + "]";
		}
		
	}

}