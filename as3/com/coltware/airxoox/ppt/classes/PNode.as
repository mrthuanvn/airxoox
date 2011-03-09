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
	
	public class PNode {
		
		protected var xml:XML;
		protected var nsR:Namespace;
		protected var nsA:Namespace;
		
		public function PNode(x:XML) {
			xml = x;
			nsR = x.namespace("r");
			nsA = x.namespace("a");
		}
		
		public function get text():String{
			return "";
		}
		
		public function toString():String{
			return xml.toXMLString();
		}
		
		public function createTLFSpan():SpanElement{
			return null;
		}
	}

}