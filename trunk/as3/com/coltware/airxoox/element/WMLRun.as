/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.element {
	public class WMLRun extends WMLNode{
		public function WMLRun(rootXml:XML,nodeXml:XML) {
			super(rootXml,nodeXml);
		}
		
		public function getText():String{
			return getTextElements().join("");
		}
		
		public override function getTextElements():Array{
			var arr:Array = new Array();
			var list:XMLList = _nodeXml.children();
			for each(var n:XML in list){
				var ln:String = n.localName();
				if(ln == "tab"){
				    arr.push("\t");
				}
				else if(ln  == "t"){
				    arr.push(n.toString());
				}
			}
			return arr;
		}
		public function setText(text:String):void{
			_nodeXml.setChildren(<w:t xmlns:w={_nsW}>{text}</w:t>);
		}
	}
}