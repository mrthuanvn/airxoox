/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt.classes {
	
	import flashx.textLayout.elements.*;
	
	public class PBr extends PNode{
		public function PBr(x:XML) {
			super(x);
		}
		
		override public function get text():String{
			return "<br>\r\n";
		}
		
		override public function createTLFSpan():SpanElement{
			var span:SpanElement = new SpanElement();
			span.text = "\r\n";
			return span;
		}
	}

}