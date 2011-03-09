/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt.classes {
	
	public class TextBody {
		
		private var _xml:XML;
		private var _nsA:Namespace;
		
		public function TextBody(xml:XML) {
			_xml = xml;
			_nsA = xml.namespace("a");
		}
		
		/**
		*  minOccurs=1
		*  maxOccurs=*
		*/
		public function getParagraphList():Array{
			var ret:Array = new Array();
			var list:XMLList = _xml._nsA::p;
			for each(var node:XML in list){
				var p:Paragraph = new Paragraph(node);
				ret.push(p);
			}
			return ret;
		}
		
		public function toString():String{
			return _xml.toXMLString();
		}
	}

}