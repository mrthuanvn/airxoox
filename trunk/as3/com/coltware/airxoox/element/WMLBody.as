/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.element {
	
	import com.coltware.airxoox.element.*;
	
	public class WMLBody extends WMLNode {
		
		public function WMLBody(rootXml:XML,nodeXml:XML) {
			super(rootXml,nodeXml);
		}
		
		public override function getChildren():Array{
			var arr:Array = new Array();
			var list:XMLList = _nodeXml._nsW::p;
			for each(var node:XML in list){
				var p:WMLParagraph = new WMLParagraph(_rootXml,node);
				arr.push(p);
			}
			
			return arr;
		}
		
		public function createParagraph():WMLParagraph{
			var p_xml:XML = <w:p xmlns:w={_nsW} />;
			var wml_p:WMLParagraph = new WMLParagraph(_rootXml,p_xml);
			return wml_p;
		}
		
		public function createAltChunk(rid:String):WMLAltChunk{
			var c_xml:XML = <w:altChunk r:id={rid} xmlns:w={_nsW} xmlns:r={_nsR} />
			var wml_c:WMLAltChunk = new WMLAltChunk(_rootXml,c_xml);
			return wml_c;
		}
		
		public function addParagraph(p:WMLParagraph):void{
			_nodeXml.appendChild(p.getXML());
		}
	}

}